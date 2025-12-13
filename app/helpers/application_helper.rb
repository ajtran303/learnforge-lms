module ApplicationHelper
  def course_progress_percentage(course, user)
    total = course.lessons.count
    return 0 if total.zero?

    completed = (user.completed_lessons & course.lessons).count
    ((completed.to_f / total) * 100).round
  end
end
