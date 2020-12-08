class Test < ApplicationRecord
  belongs_to :category

  def self.title_tests_by_category(category)
    title_tests = []

    Test.select(:title)
      .joins(:category)
      .where('categories.title = ?', category)
      .order(created_at: :desc)
      .each { |test| title_tests << test.title }

    title_tests
  end
end
