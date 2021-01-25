module ManageBadge

  # constructor for filter Tests
  class TestRules < ApplicationService
    REGEX_PARSE = /([test]+)(\()*([a-z0-9]+)*(\))*(\.)*([a-z]+)*([=><]+)*([a-z0-9]+)*/

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
end