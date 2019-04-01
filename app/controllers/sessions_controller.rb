class SessionsController < ApplicationController

  def new
    @users = User.all
  end

  def create
    session[:current_user_id] = params[:user_id]

    if current_user
      redirect_to current_user
    else
      redirect_to :new_session
    end
  end

  def sign_out
    session[:current_user_id] = nil
    redirect_to :new_session
  end
end
