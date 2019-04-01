class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  after_action :verify_authorized, unless: :sessions_controller?

  private

  def current_user
    @current_user ||= User.find_by id: session[:current_user_id]
  end
  helper_method :current_user

  def sessions_controller?
    controller_name == 'sessions'
  end
end
