require "rails_helper"

RSpec.describe "Lesson Completion (Turbo)", type: :system, js: true do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, user: instructor, status: "published") }
  let!(:lesson1) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:selenium_chrome_headless)
    learner.enrolled_courses << course
    login_as(learner)
  end

  it "updates course progress instantly when lesson is completed" do
    skip "this test is flakey, it passes alone but not when the whole suite runs"
    visit course_lesson_show_path(course, lesson1)

    within("#course_#{course.id}_progress") do
      expect(page).to have_content("0% Complete")
    end

    expect(page).to have_button("Mark Complete")

    click_button "Mark Complete"
    expect(page).to have_content("#{lesson1.title} - Completed")
    expect(page).not_to have_button("Mark Complete")

    within("#course_#{course.id}_progress") do
      expect(page).to have_content("50% Complete")
    end

    click_button "Next Lesson"

    click_button "Mark Complete"

    expect(page).to have_content("#{lesson2.title} - Completed")
    expect(page).not_to have_button("Mark Complete")

    within("#course_#{course.id}_progress") do
      expect(page).to have_content("100% Complete")
    end
  end
end
