class CoursesController < ApplicationController
  before_action :require_login
  before_action :require_instructor, only: [ :new, :create, :edit, :update, :destroy ]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    @course.status = "draft"

    if @course.save
      redirect_to course_path(@course), notice: "Course created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @course = Course.find(params[:id])
    @lesson = Lesson.new(course: @course) if current_user&.instructor?
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to course_path(@course), notice: "Course updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])

    @course.destroy
    redirect_to dashboard_path, notice: "Course deleted successfully"
  end

  def publish
    @course = current_user.courses.find(params[:id])

    if @course.update(status: "published")
      redirect_to course_path(@course), notice: "Course published successfully"
    end
  end

  def unpublish
    @course = current_user.courses.find(params[:id])

    if @course.update(status: "draft")
      redirect_to course_path(@course), notice: "Course reverted to draft"
    end
  end

  def enroll
    @course = Course.find(params[:id])
    current_user.enrolled_courses << @course unless current_user.enrolled_courses.include?(@course)
    flash.now[:notice] = "You have successfully enrolled in the course!"

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to course_path(@course), notice: "You have successfully enrolled in the course!" }
    end
  end

  def unenroll
    @course = Course.find(params[:id])
    current_user.enrolled_courses.delete(@course)
    current_user.lesson_completions.joins(:lesson).where(lessons: { course_id: @course.id }).destroy_all
    flash.now[:notice] = "You have successfully unenrolled from the course"

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to course_path(@course), notice: "You have successfully unenrolled from the course" }
    end
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

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
