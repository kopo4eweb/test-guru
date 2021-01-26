class TestPassage < ApplicationRecord
  PERCENT_SUCCESS = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_next_question

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    
    self.percent = percent_success_answer

    save!
  end

  def percent_success_answer
    if correct_questions.positive?
      ((correct_questions.to_f / test.questions.count.to_f) * 100).round(1)
    else
      0
    end
  end

  def success?
    percent_success_answer >= PERCENT_SUCCESS
  end

  def total_questions
    test.questions.count
  end

  def passed_questions
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  # time left in seconds
  def time_left
    end_time = created_at + test.time_for_test
    time_left_seconds = end_time - Time.now
    
    return 0 if time_left_seconds < 0

    time_left_seconds.round
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort unless answer_ids.nil?
  end

  def correct_answers
    current_question.answers.correct
  end

  def before_update_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first unless self.current_question.nil?
  end
end
