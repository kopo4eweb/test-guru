class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  has_many :created_tests, class_name: 'Test'

  validates :name, :email, presence: true

  def find_tests_by_level(level)
    tests.where(level: level)
  end  
end
