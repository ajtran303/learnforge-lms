class LessonCompletionsController < ApplicationController
  before_action :require_login
  before_action :set_course_and_lesson

  def create
    current_user.completed_lessons << @lesson unless current_user.completed_lessons.include?(@lesson)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "lesson_completion",
          partial: "lessons/lesson_completion",
          locals: { lesson: @lesson }
        )
      end
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
