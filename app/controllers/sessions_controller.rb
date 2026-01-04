class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, alert: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logged out successfully!"
  end

  def demo
    demo_user = User.find_by(email: "student@example.com")

    if demo_user
      session[:user_id] = demo_user.id
      redirect_to dashboard_path, alert: "Logged in as demo student!"
    else
      redirect_to new_session_path, alert: "Demo account not available"
    end
  end
end
