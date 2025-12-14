class LessonsController < ApplicationController
  before_action :require_login
  before_action :require_instructor, except: :show
  before_action :set_course

  def create
    @lesson = @course.lessons.new(lesson_params)

    if @lesson.save
      flash[:notice] = "Lesson created successfully"

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to course_path(@course), notice: "Lesson created successfully" }
      end
    else
      @course = @lesson.course
      render "courses/show", status: :unprocessable_entity
    end
  end

  def show
    @lesson = @course.lessons.find(params[:id])
    @course = @lesson.course
  end

  def edit
    @lesson = @course.lessons.find(params[:id])
  end

  def update
    @lesson = @course.lessons.find(params[:id])

    if @lesson.update(lesson_params)
      flash.now[:notice] = "Lesson updated successfully"

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to course_path(@course), notice: "Lesson updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson = @course.lessons.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html do
        flash[:lesson_deleted] = "Lesson deleted successfully"
        redirect_to course_path(@course)
      end
      format.turbo_stream do
        flash.now[:lesson_deleted] = "Lesson deleted successfully" # for Turbo
        render turbo_stream: turbo_stream.remove(@lesson)
      end
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
