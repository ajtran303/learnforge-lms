require "rails_helper"

RSpec.describe "Lesson Viewer", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, user: instructor, status: "published") }

  let!(:lesson1) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson3) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:rack_test)
    learner.enrolled_courses << course
    login_as(learner)
  end

  context "as a learner with an enrolled course" do
    it "can navigate to the lesson viewer and start a course" do
      visit dashboard_path
      click_link course.title
      expect(page).to have_current_path(course_path(course))

      click_button "Start Course"

      expect(page).to have_current_path(course_lesson_show_path(course, lesson1))
    end

    it "resumes progress after completed lessons" do
      LessonCompletion.create(user: learner, lesson: lesson1)
      LessonCompletion.create(user: learner, lesson: lesson2)

      visit dashboard_path
      click_link course.title
      expect(page).to have_current_path(course_path(course))

      click_button "Open Course"

      expect(page).to have_current_path(course_lesson_show_path(course, lesson3))
    end

    it "opens the first lesson after completing all lessons" do
      LessonCompletion.create(user: learner, lesson: lesson1)
      LessonCompletion.create(user: learner, lesson: lesson2)
      LessonCompletion.create(user: learner, lesson: lesson3)

      visit dashboard_path
      click_link course.title
      expect(page).to have_current_path(course_path(course))

      click_button "Open Course"

      expect(page).to have_current_path(course_lesson_show_path(course, lesson1))
    end

    it "shows lesson content" do
      visit course_lesson_show_path(course, lesson1)

      expect(page).to have_content(course.title)
      expect(page).to have_content(lesson1.title)
      expect(page).to have_content(lesson1.content)
    end

    it "shows a sidebar with all the lessons" do
      visit course_lesson_show_path(course, lesson1)

      within ".lessons-sidebar" do
        expect(page).to have_content(lesson1.title)
        expect(page).to have_content(lesson2.title)
        expect(page).to have_content(lesson3.title)
      end
    end

    it "shows next lesson link" do
      visit course_lesson_show_path(course, lesson1)

      expect(page).to have_button("Next Lesson")
    end

    it "shows previous lesson link" do
      visit course_lesson_show_path(course, lesson2)

      expect(page).to have_button("Previous Lesson")
    end

    it "does not show previous lesson link for first lesson" do
      visit course_lesson_show_path(course, lesson1)

      expect(page).not_to have_button("Previous Lesson")
    end

    it "does not show next lesson link for last lesson" do
      visit course_lesson_show_path(course, lesson3)

      expect(page).not_to have_button("Next Lesson")
    end
  end
end
