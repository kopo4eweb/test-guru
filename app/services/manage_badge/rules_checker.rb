module ManageBadge

  class RulesChecker < ApplicationService
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
        complited_logic_code = " #{run_rule(get_rule("#{start_class_name}Rules.call('#{items[0]}')"))} "
      else
        items.each do |item|
          if item.downcase =~ /^(and|or|\|\||&&)$/
            # and | or
            complited_logic_code += " #{item.downcase} "
          else
            start_class_name = parsing(item)
            # return true | false | nil
            complited_logic_code += " #{run_rule(get_rule("#{start_class_name}Rules.call('#{item}')"))} "
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
end