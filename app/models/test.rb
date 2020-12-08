class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  has_many :tests_users
  has_many :users, through: :tests_users

  def self.title_tests_by_category(category)
    Test.joins(:category)
      .where('categories.title = ?', category)
      .order(created_at: :desc)
      .pluck(:title)
  end
end
