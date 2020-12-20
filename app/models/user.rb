class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages

  has_many :created_tests, class_name: 'Test'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A(.+)@(.+)\z/, message: "not valid" }

  has_secure_password

  def find_tests_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
