require "rails_helper"

RSpec.describe "Lesson Completion", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, user: instructor) }
  let!(:lesson) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:rack_test)
    learner.enrolled_courses << course
    login_as(learner)
  end

  context "when a learner completes a lesson" do
    it "the lesson can be marked as completed" do
      visit course_lesson_show_path(course, lesson)

      expect(page).to have_button("Mark Complete")

      click_button "Mark Complete"

      # Turbo interaction
      expect(page).to have_content("Completed")
      expect(page).not_to have_button("Mark Complete")
    end

    it "does not show the button when the lesson is completed" do
      learner.completed_lessons << lesson

      visit course_lesson_show_path(course, lesson)

      expect(page).to have_content("Completed")
      expect(page).not_to have_button("Mark Complete")
    end
  end
end
