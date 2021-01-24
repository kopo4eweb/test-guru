class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  # Cleaning the test_passages table from abandoned tests
  before_destroy do
    test.test_passages.where(current_question_id: self.id).each do |test_passage|
      test_passage.current_question_id = nil
      test_passage.save!
    end
  end

  has_many :gists, dependent: :destroy

  validates :body, presence: true
end
