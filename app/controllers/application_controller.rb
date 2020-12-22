class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def after_sign_in_path_for(resource)
    flash[:hello] = "Hello, #{current_user.first_name}!"

    if resource.is_a?(Admin)
      admin_tests_path
    else
      root_path
    end
  end

  def rescue_record_not_found
    render plain: "404 Not Found", status: 404
  end
end
