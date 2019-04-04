class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  after_action :verify_authorized, unless: :sessions_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find_by id: session[:current_user_id]
  end
  helper_method :current_user

  def user_not_authorized
    render file: "#{Rails.public_path}/404.html" , status: :not_found
  end

  def sessions_controller?
    controller_name == 'sessions'
  end
end
