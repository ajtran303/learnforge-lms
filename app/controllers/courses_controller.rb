class CoursesController < ApplicationController
  before_action :require_login
  before_action :require_instructor

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
