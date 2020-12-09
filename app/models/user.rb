class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  has_many :tests_owner, class_name: 'Test'

  def find_tests_by_level(level)
    tests.where(level: level)
  end

  validates :name, :email, presence: true
end
