class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  has_many :tests_users
  has_many :users, through: :tests_users

  belongs_to :user
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  def self.title_tests_by_category(category)
    Test.joins(:category)
    .where('categories.title = ?', category)
    .order(created_at: :desc)
    .pluck(:title)
  end
end
