module ManageBadge

  # constructor for filter Category
  class CategoryRules < ApplicationService
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
        custom_code = category_is_defined(object)
      end

      custom_code
    end

    private

    def category_is_defined(id)
      custom_code = 'false'

      if object =~ /\d+/
        custom_code =  "count_test_with_category = Category.where(id: #{object}).first.tests.ready.count; "
        custom_code += "if count_test_with_category > 0; "
        custom_code += "tests_ids_in_category = Category.where(id: #{object}).first.tests.ready.ids.sort; "
        custom_code += "count_test_with_category == user.test_passages.where(test_id: tests_ids_in_category).select('test_id').distinct.count; "
        custom_code += "else; false; end; "
      end

      custom_code
    end

    def parsing
      self.model, s1, self.object, s2 = REGEX_PARSE.match(rule.downcase).captures
    end
  end
end