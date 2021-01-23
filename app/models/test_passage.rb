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

    add_badges if completed? && success?
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
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def add_badges
    badge_group_counts = Badge.user_group_badges_count(self.user)

    Badge.show_active.each do |badge|

      next if skip_add_badge?(badge, badge_group_counts)

      if Rules::BadgeRules.new(self, badge.rule).call
        self.user.user_badges.new(badge: badge, test_passage: self.test).save!
      end
    end
  end

  def skip_add_badge?(badge, badge_group_counts)
    # если такой бейдж назначен за этот тест, пропусткаем, не назначаем
    # or
    # Если лимит позволяет использовать этот бейдж у этого пользователя, есть бейджи которые пользователь может получить только 1 раз
    self.user.user_badges.where(badge: badge, test_passage: self.test.id).size > 0 || badge.usage_limit <= badge_group_counts[badge.id].to_i
  end
end
