class DashboardController < ApplicationController
  before_action :require_login
  def show
  end

  def require_login
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in"
    end
  end
end
