class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  has_many :tests_users
  has_many :users, through: :tests_users

  belongs_to :author, class_name: "User", foreign_key: "user_id"

  scope :level_plain, -> { where(level: 0..1) }
  scope :level_middle, -> { where(level: 2..4) }
  scope :level_complicated, -> { where(level: 5..Float::INFINITY) }

  scope :tests_by_category, -> (category) do 
    joins(:category)
    .where('categories.title = ?', category)    
  end

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.title_tests_by_category(category)
    tests_by_category(category)
      .order(created_at: :desc)
      .pluck(:title)
  end
end
