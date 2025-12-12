# spec/system/lessons_spec.rb
require 'rails_helper'

RSpec.describe "Lessons Management", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:course) { FactoryBot.create(:course, user: instructor) }
  let!(:lesson) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by(:rack_test)
    login_as(instructor)
  end

  describe "Editing a lesson" do
    it "allows the instructor to edit a lesson title and content" do
      visit course_path(course)

      expect(page).to have_content(course.title)
      expect(page).to have_link("Edit", href: edit_course_lesson_path(course, lesson))
      click_link "Edit"

      # Ensure we're on the edit page
      expect(page).to have_current_path(edit_course_lesson_path(course, lesson))
      expect(page).to have_content("Edit Lesson")

      # Fill in the form with new values
      fill_in "Title", with: "Updated Lesson Title"
      fill_in "Content", with: "Updated lesson content"
      click_button "Update Lesson"

      # Verify that the lesson was updated and redirected
      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("Lesson updated successfully")
      expect(page).to have_content("Updated Lesson Title")
      expect(page).to have_content("Updated lesson content")
    end
  end

  describe "Deleting a lesson" do
    it "allows the instructor to delete a lesson" do
      driven_by :selenium_chrome_headless

      login_as(instructor)
      visit course_path(course)

      expect(page).to have_content(lesson.title)

      accept_confirm do
        click_button "Delete"
      end

      expect(page).to have_current_path(course_path(course))
      # expect(page).to have_content("Lesson deleted successfully")
      expect(page).not_to have_content(lesson.title)
    end
  end
end
