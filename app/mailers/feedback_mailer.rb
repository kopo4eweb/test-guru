class FeedbackMailer < ApplicationMailer
  def completed_feedback(feedback)
    @email = feedback.email
    @message = feedback.message

    mail to: Admin.last.email, subject: I18n.t('mailer.feedback.subject')
  end
end
