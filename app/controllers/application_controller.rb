class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  private

  def rescue_record_not_found
    render plain: "404 Not Found", status: 404
  end
end
