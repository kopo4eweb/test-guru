class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    unless current_user
      cookies[:from_page] = request.path
      redirect_to login_path, alert: 'Are you a Guru? Verity your Email and Password please'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    session[:user_id] = nil
  end
end
