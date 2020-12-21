class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      authenticate_user(user)
      redirect_to cookies.delete(:from_page) || root_path
    else
      flash.now[:alert] = 'Are you a Guru? Verity your Email and Password please'
      render :new
    end
  end

  def logout
    logout_user
    redirect_to root_path
  end
end
