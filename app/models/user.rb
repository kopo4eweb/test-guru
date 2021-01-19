class User < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :confirmable          

  has_many :test_passages
  has_many :tests, through: :test_passages

  has_many :created_tests, class_name: 'Test'

  has_many :gists

  has_many :user_badges
  has_many :badges, through: :user_badges

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def find_tests_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
