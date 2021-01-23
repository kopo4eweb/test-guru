class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  belongs_to :test_passage, class_name: 'Test', optional: true
end
