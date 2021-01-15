class Feedback
  EMAIL_FORMAT = /^(.+)@(.+)$/i.freeze

  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attr_reader :errors
  attr_accessor :email, :message

  def initialize(params = {})
    @errors = ActiveModel::Errors.new(self)
    @email = params[:email] || ''
    @message = params[:message] || ''
  end

  def id
    'not-id'
  end

  def valid?
    validate!
    return false if errors.count.positive?

    true
  end

  def validate!
    errors.add(:email, :email_not_valid) unless email =~ EMAIL_FORMAT
    errors.add(:email, :blank) if email.nil? || email.empty?
    errors.add(:message, :blank) if message.nil? || message.empty?
  end

  def read_attribute_for_validation(attr)
    send(attr)
  end
end
