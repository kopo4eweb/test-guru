class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def feedback
    @feedback = Feedback.new
  end

  def send_feedback
    @feedback = Feedback.new(feedback_params)

    if @feedback.valid?
      FeedbackMailer.completed_feedback(@feedback).deliver_now
      redirect_to :feedback, notice: t('.success')
    else
      render :feedback
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :message)
  end
end