class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :title, presence: true

  validate :validate_max_answers, on: :create

  def validate_max_answers
    errors.add(:base, I18n.t('custom_valid.max_answers', max: MAX_ANSWERS)) if question.answers.count >= MAX_ANSWERS
  end
end
