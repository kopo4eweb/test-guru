class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy

  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  belongs_to :author, class_name: "User", foreign_key: "user_id"

  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  scope :ready, -> do 
    where(public: true)
    .order(updated_at: :ASC)
  end

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
