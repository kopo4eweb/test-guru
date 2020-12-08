class Test < ApplicationRecord
  belongs_to :category

  def self.title_tests_by_category(category)
    Test.joins(:category)
      .where('categories.title = ?', category)
      .order(created_at: :desc)
      .pluck(:title)
  end
end
