class Test < ApplicationRecord
  belongs_to :category

  def self.find_tests_by_category(category)
    Test.joins('JOIN categories ON tests.category_id = categories.id')
      .where('categories.title = ?', category)
  end
end
