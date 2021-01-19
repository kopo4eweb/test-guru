class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :user, through: :user_badges

  validates :title, :url, presence: true
end
