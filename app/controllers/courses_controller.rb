class CoursesController < ApplicationController
  before_action :require_instructor

  def new
    @course = Course.new
  end

  private

  def require_instructor
    render plain: "Forbidden", status: :forbidden unless current_user&.role == "instructor"
  end
end
