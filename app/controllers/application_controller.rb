class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }    
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def after_sign_in_path_for(resource)
    flash[:hello] = t('hello', name: current_user.first_name)

    if resource.admin?
      admin_tests_path
    else
      root_path
    end
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  def rescue_record_not_found
    render plain: t('not_found_404'), status: 404
  end
end
