class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  belongs_to :question

  scope :corrects, -> { where(correct: true) }

  validates :title, presence: true

  validate :validate_max_answers, on: :create

  def validate_max_answers
    errors.add(:id, "maximum answers on question #{MAX_ANSWERS}") if question.answers.size >= MAX_ANSWERS
  end
end
