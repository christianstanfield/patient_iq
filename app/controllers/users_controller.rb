class UsersController < ApplicationController
  before_action :load_resource, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def load_resource
    @user = User.find_by id: params[:id]
    authorize @user
  end

  def user_params
    permitted_params = permitted_attributes @user

    unless params[:user][:password].present?
      permitted_params.delete(:password)
      permitted_params.delete(:password_confirmation)
    end

    permitted_params
  end
end
