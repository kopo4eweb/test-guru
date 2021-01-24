module Rules

  class BadgeRules
    REGEX_PARSE = /^([A-Za-z]+)*/
  
    attr_reader :test_passage, :user, :test, :rule
    attr_accessor :items
  
    def initialize(test_passage, rule)
      @test_passage = test_passage
      @user = test_passage.user
      @test = test_passage.test
      @rule = rule
      @items = []
    end
  
    def call
      splitting
      clean
      run
    end
  

    private
  
    def run
      complited_logic_code = ''

      if items.length == 1
        start_class_name = parsing(items[0])
        # return true | false | nil
        complited_logic_code = " #{run_rule(get_rule("#{start_class_name}Rules.new('#{items[0]}').call"))} "
      else
        items.each do |item|
          if item.downcase =~ /^(and|or|\|\||&&)$/
            # and | or
            complited_logic_code += " #{item.downcase} "
          else
            start_class_name = parsing(item)
            # return true | false | nil
            complited_logic_code += " #{run_rule(get_rule("#{start_class_name}Rules.new('#{item}').call"))} "
          end
        end
      end

      run_logic_code(complited_logic_code)
    end
  
    def get_rule(class_rule_str)
      self.send(self.class.class_eval("def define_rule; #{class_rule_str}; end"))
    rescue StandardError => e
      raise ScriptError, e, caller
    end

    def run_rule(completed_rule_str)
      self.send(self.class.class_eval("def execute_rule; #{completed_rule_str}; end"))
    end

    def run_logic_code(complited_logic_code)
      self.send(self.class.class_eval("def execute_logic_code; #{complited_logic_code}; end"))
    end
    
    def splitting
      self.items = rule.split(';')
    end

    def clean
      items.each_index do |i|
        self.items[i] = items[i].tr(' ', '')
      end
    end
  
    def parsing(item)
      REGEX_PARSE.match(item).captures[0].to_s.capitalize
    end
  end


  # constructor for filter Tests
  class TestRules
    REGEX_PARSE = /([test]+)(\()*([a-z0-9]+)*(\))*(\.)*([a-z]+)*(==|>|<)*([a-z0-9]+)*/

    attr_reader :rule
    attr_accessor :model, :object, :function, :expression, :value

    def initialize(rule)
      @rule = rule
    end

    def call
      parsing
  
      custom_code = ''
  
      if object.nil?      
        custom_code += current_test
      else        
        case object
        when /\d+/
          custom_code += test_is_defined(object)
        when /all/
          custom_code += "Test.ready.count == user.test_passages.select('test_id').distinct.count;"
        else
          custom_code += 'false;'
        end  
      end

      custom_code
    end

    private
    
    def test_is_defined(id)
      custom_code = ''

      case function
      when 'count'
        custom_code += "user.test_passages.where(test_id: #{id}).#{function} #{expression} #{value};"
      when 'level'
        custom_code += "find_user_test = user.test_passages.where(test_id: #{id}).first; "
        custom_code += "if find_user_test; "
        custom_code += "find_user_test.test.#{function} #{expression} #{value}; "
        custom_code += "else; false; end;"
      when 'percent'
        custom_code += "find_user_test = user.test_passages.where(test_id: #{id}); "
        custom_code += "if find_user_test.size > 0; "
        custom_code += "find_user_test.maximum(:#{function}) #{expression} #{value}; "
        custom_code += "else; false; end;"
      else
        custom_code = 'false;'
      end
  
      custom_code
    end

    def current_test
      custom_code = ''

      case function
      when 'count'
        custom_code += "user.test_passages.where(test: test).#{function} #{expression} #{value};"
      when 'level'
        custom_code += "test.#{function} #{expression} #{value};"
      when 'percent'
        custom_code += "test_passage.#{function} #{expression} #{value};"
      else
        custom_code = 'false;'
      end
  
      custom_code
    end
    
    def parsing
      self.model, s1, self.object, s2, p1, self.function, self.expression, self.value = REGEX_PARSE.match(rule.downcase).captures
    end
  end

  # constructor for filter Category
  class CategoryRules
    REGEX_PARSE = /([category]+)(\()*([0-9]+)*(\))*/

    attr_reader :rule
    attr_accessor :model, :object

    def initialize(rule)
      @rule = rule
    end

    def call
      parsing
  
      custom_code = ''

      if object.nil?
        custom_code += "count_test_with_category = test.category.tests.ready.count; "
        custom_code += "tests_ids_in_category = test.category.tests.ready.ids.sort; "
        custom_code += "count_test_with_category == user.test_passages.where(test_id: tests_ids_in_category).select('test_id').distinct.count;"
      else
        if object =~ /\d+/
          custom_code += "count_test_with_category = Category.where(id: #{object}).first.tests.ready.count; "
          custom_code += "if count_test_with_category > 0; "
          custom_code += "tests_ids_in_category = Category.where(id: #{object}).first.tests.ready.ids.sort; "
          custom_code += "count_test_with_category == user.test_passages.where(test_id: tests_ids_in_category).select('test_id').distinct.count; "
          custom_code += "else; false; end; "
        else
          custom_code = 'false'
        end
      end

      custom_code
    end

    private

    def parsing
      self.model, s1, self.object, s2 = REGEX_PARSE.match(rule.downcase).captures
    end
  end
end