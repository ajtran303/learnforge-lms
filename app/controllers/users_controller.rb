class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = "learner"

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Welcome, #{@user.email}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
