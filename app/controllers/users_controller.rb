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
  end

  def user_params
    permitted_params = [:role, :department_id, :phone, :address, :email, :salary, :bonus]

    if params[:user][:password].present?
      permitted_params += [:password, :password_confirmation]
    end

    params.require(:user).permit(permitted_params)
  end
end
