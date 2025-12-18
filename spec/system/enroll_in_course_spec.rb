require "rails_helper"

RSpec.describe "Enroll in Course", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, user: instructor) }
  let!(:lesson1) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:rack_test)
    login_as(learner)
  end

  context "when the learner is not enrolled in the course" do
    it "enrolls the learner and redirects to the first lesson" do
      visit course_path(course)

      expect(page).to have_button("Enroll In This Course To View Lessons")

      click_button "Enroll In This Course To View Lessons"

      expect(learner.enrolled_courses).to include(course)

      expect(page).to have_current_path(course_lesson_show_path(course, lesson1))
      expect(page).to have_content("Lesson 1")
    end
  end
end
