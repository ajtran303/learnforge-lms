require 'rails_helper'

RSpec.describe "Course Detail Page", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course) { FactoryBot.create(:course, title: "Ruby Basics", description: "Learn Ruby from scratch", user: instructor, status: "published") }
  let!(:lesson1) { FactoryBot.create(:lesson, course: course, title: "Introduction to Ruby", content: "Learn the basics of Ruby.") }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course, title: "Ruby Data Structures", content: "Learn about arrays, hashes, and more.") }

  before do
    driven_by(:rack_test)
  end

  describe "Learner viewing a course" do
    it "displays course info and enroll button if not enrolled" do
      login_as(learner)
      visit course_path(course)

      expect(page).to have_content(course.title)
      expect(page).to have_content(course.description)
      expect(page).to have_content("Instructor: #{course.user.email}")

      expect(page).not_to have_content(lesson1.title)
      expect(page).not_to have_content(lesson2.title)

      expect(page).to have_button("Enroll In This Course To View Lessons")
    end

    it "does not show enroll button if the learner is already enrolled" do
      learner.enrolled_courses << course
      login_as(learner)
      visit course_path(course)

      expect(page).not_to have_button("Enroll In This Course To View Lessons")
      expect(page).to have_content("You are already enrolled in this course.")

      expect(page).to have_content(lesson1.title)
      expect(page).to have_content(lesson2.title)
    end
  end
end
