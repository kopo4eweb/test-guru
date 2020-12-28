class Question < ApplicationRecord
  MAX_SHORT_STRING = 25

  belongs_to :test
  has_many :answers

  has_many :gists

  validates :body, presence: true

  def short_body
    result_string = body.slice(0..MAX_SHORT_STRING)

    result_string += '...' if body.length > 25

    result_string
  end
end
