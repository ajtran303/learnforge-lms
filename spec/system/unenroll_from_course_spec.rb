require "rails_helper"

RSpec.describe "Unenroll from Course", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, user: instructor, status: "published") }
  let!(:lesson1) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:rack_test)
    learner.enrolled_courses << course
    login_as(learner)
  end

  context "when the learner is enrolled in the course" do
    it "shows an unenroll button on the course page" do
      visit course_path(course)

      expect(page).to have_button("Unenroll")
    end

    it "unenrolls the learner from the course" do
      visit course_path(course)

      expect(page).to have_content("Lessons")

      click_button "Unenroll"

      expect(learner.enrolled_courses.reload).not_to include(course)
      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("You have successfully unenrolled from the course")
      expect(page).to have_button("Enroll")
      expect(page).not_to have_content("Lessons")
      expect(page).to have_content("Enroll to view lessons")
    end

    it "resets lesson completion progress when unenrolling" do
      learner.completed_lessons << lesson1
      learner.completed_lessons << lesson2

      expect(learner.lesson_completions.count).to eq(2)

      visit course_path(course)
      click_button "Unenroll"

      expect(learner.lesson_completions.reload.count).to eq(0)
    end

    it "only resets progress for the unenrolled course" do
      other_course = FactoryBot.create(:course, user: instructor, status: "published")
      other_lesson = FactoryBot.create(:lesson, course: other_course)
      learner.enrolled_courses << other_course

      learner.completed_lessons << lesson1
      learner.completed_lessons << other_lesson

      expect(learner.lesson_completions.count).to eq(2)

      visit course_path(course)
      click_button "Unenroll"

      expect(learner.lesson_completions.reload.count).to eq(1)
      expect(learner.completed_lessons).to include(other_lesson)
      expect(learner.completed_lessons).not_to include(lesson1)
    end
  end
end
