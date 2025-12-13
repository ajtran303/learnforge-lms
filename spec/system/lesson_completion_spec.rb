require "rails_helper"

RSpec.describe "Lesson Completion", type: :system do
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

  context "when a learner completes a lesson" do
    it "the lesson can be marked as completed" do
      visit course_lesson_show_path(course, lesson1)

      expect(page).to have_button("Mark Complete")

      click_button "Mark Complete"

      # Turbo interaction
      expect(page).to have_content("Completed")
      expect(page).not_to have_button("Mark Complete")
    end

    it "does not show the button when the lesson is completed" do
      learner.completed_lessons << lesson1

      visit course_lesson_show_path(course, lesson1)

      expect(page).to have_content("Completed")
      expect(page).not_to have_button("Mark Complete")
    end

    context "Course Progress" do
      def expect_progress(page_path, expected)
        visit page_path
        within("#course_#{course.id}_progress, #course_progress") do
          expect(page).to have_content("#{expected}% Complete")
        end
      end

      it "shows correct progress as lessons are completed" do
        expect_progress(dashboard_path, 0)
        expect_progress(course_path(course), 0)
        expect_progress(course_lesson_show_path(course, lesson1), 0)

        learner.completed_lessons << lesson1
        expect_progress(dashboard_path, 33)
        expect_progress(course_path(course), 33)
        expect_progress(course_lesson_show_path(course, lesson1), 33)

        learner.completed_lessons << lesson2
        expect_progress(dashboard_path, 67)
        expect_progress(course_path(course), 67)
        expect_progress(course_lesson_show_path(course, lesson2), 67)

        learner.completed_lessons << lesson3
        expect_progress(dashboard_path, 100)
        expect_progress(course_path(course), 100)
        expect_progress(course_lesson_show_path(course, lesson3), 100)
      end
    end
  end
end
