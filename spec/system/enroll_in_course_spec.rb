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
    it "enrolls the learner and stays on the course page" do
      visit course_path(course)

      expect(page).to have_button("Enroll")
      expect(page).not_to have_content("Lessons")

      click_button "Enroll"

      expect(learner.enrolled_courses.reload).to include(course)
      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("You have successfully enrolled in the course!")
      expect(page).to have_content("Lessons")
      expect(page).to have_button("Start Course")
    end
  end
end
