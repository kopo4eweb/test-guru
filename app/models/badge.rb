class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :user, through: :user_badges

  scope :sort_updated_at_desc, -> { order(updated_at: :desc) }
  scope :show_active, -> { where(active: true) }

  validates :title, :url, presence: true

  validates :usage_limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def self.user_group_badges_count(user)
    user.user_badges.group(:badge_id).count
  end
end
