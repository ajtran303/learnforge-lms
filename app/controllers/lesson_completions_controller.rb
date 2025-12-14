class LessonCompletionsController < ApplicationController
  before_action :require_login
  before_action :set_course_and_lesson

  def create
    unless current_user.completed_lessons.include?(@lesson)
      LessonCompletion.find_or_create_by!(user: current_user, lesson: @lesson)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to course_lesson_show_path(@course, @lesson), notice: "Completed" }
    end
  end

  private

  def set_course_and_lesson
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end

  def require_login
    redirect_to new_session_path, alert: "You must be logged in" unless current_user
  end
end
