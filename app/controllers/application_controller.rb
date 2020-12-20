class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    unless current_user
      save_page_destination
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

  def save_page_destination
    cookies[:url] = request.path
  end

  def go_over_page_destination(controller_path)
    redirect_to cookies[:url] ? cookies[:url] : controller_path
    cookies[:url] = nil
  end
end
