class CoursesController < ApplicationController
  before_action :require_login
  before_action :require_instructor

  def new
    @course = Course.new
  end

  private

  def require_login
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in"
    end
  end

  def require_instructor
    render plain: "Forbidden", status: :forbidden unless current_user&.role == "instructor"
  end
end
