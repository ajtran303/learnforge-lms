class LessonsController < ApplicationController
  before_action :require_login
  before_action :require_instructor
  before_action :set_course

  def create
    @lesson = @course.lessons.new(lesson_params)

    if @lesson.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to course_path(@course), notice: "Lesson created successfully" }
      end
    else
      @course = @lesson.course
      render "courses/show", status: :unprocessable_entity
    end
  end

  private

  def require_login
    redirect_to new_session_path, alert: "You must be logged in" unless current_user
  end

  def require_instructor
    render plain: "Forbidden", status: :forbidden unless current_user&.role == "instructor"
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content)
  end
end
