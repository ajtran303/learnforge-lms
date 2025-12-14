module CoursesHelper
  def course_entry_label(course, user)
    user.completed_lessons.where(course_id: course.id).exists? ?
      "Open Course" :
      "Start Course"
  end


  def next_uncompleted_lesson(course, user)
    completed_ids = user.completed_lessons
                        .where(course_id: course.id)
                        .pluck(:id)

    course.lessons
          .where.not(id: completed_ids)
          .order(:id)
          .first
  end
end
