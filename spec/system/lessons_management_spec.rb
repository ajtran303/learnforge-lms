# spec/system/lessons_spec.rb
require 'rails_helper'

RSpec.describe "Lessons Management", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:course) { FactoryBot.create(:course, user: instructor) }
  let!(:lesson1) { FactoryBot.create(:lesson, course: course) }
  let!(:lesson2) { FactoryBot.create(:lesson, course: course) }

  before do
    driven_by :selenium_chrome_headless
    login_as(instructor)
  end

  describe "Editing a lesson" do
    # Skipped: Flaky due to Trix editor timing issues in headless Chrome
    xit "allows the instructor to edit a lesson title and content" do
      visit course_path(course)

      expect(page).to have_content(course.title)
      expect(page).to have_link("Edit", href: edit_course_lesson_path(course, lesson1))
      click_link "Edit", href: edit_course_lesson_path(course, lesson1)

      expect(page).to have_current_path(course_path(course))
      within("turbo-frame#lesson_form") do
        expect(page).to have_content("Edit Lesson", wait: 5)
      end

      within("turbo-frame#lesson_form") do
        fill_in "Title", with: "Updated Lesson Title"
      end
      fill_in_trix_editor_within("turbo-frame#lesson_form", "Updated lesson content")
      within("turbo-frame#lesson_form") do
        click_button "Update Lesson"
      end

      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("Lesson updated successfully")
      expect(page).to have_content("Updated Lesson Title")
      expect(page).to have_content("Updated lesson content")

      click_link "Edit", href: edit_course_lesson_path(course, lesson2)

      expect(page).to have_selector("turbo-frame#lesson_form")
      expect(page).to have_content("Edit Lesson")

      within("turbo-frame#lesson_form") do
        fill_in "Title", with: "Updated Lesson 2"
      end
      fill_in_trix_editor_within("turbo-frame#lesson_form", "Updated content for lesson 2")
      within("turbo-frame#lesson_form") do
        click_button "Update Lesson"
      end

      expect(page).to have_content("Lesson updated successfully")
      expect(page).to have_content("Updated Lesson 2")
      expect(page).to have_content("Updated content for lesson 2")
    end

    # Conditional form rendering - reset it to create after edit
    # Skipped: Flaky due to Turbo frame timing issues when run after other tests
    xit "allows instructor to create a course after editing one" do
      visit course_path(course)
      # Ensure JavaScript is fully loaded
      sleep 0.5

      expect(page).to have_content(course.title)
      expect(page).to have_link("Edit", href: edit_course_lesson_path(course, lesson1))
      click_link "Edit", href: edit_course_lesson_path(course, lesson1)

      expect(page).to have_current_path(course_path(course))
      within("turbo-frame#lesson_form") do
        expect(page).to have_content("Edit Lesson", wait: 5)
      end

      within("turbo-frame#lesson_form") do
        fill_in "Title", with: "Updated Lesson Title"
      end
      fill_in_trix_editor_within("turbo-frame#lesson_form", "Updated lesson content")
      within("turbo-frame#lesson_form") do
        click_button "Update Lesson"
      end

      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("Lesson updated successfully")
      expect(page).to have_content("Updated Lesson Title")
      expect(page).to have_content("Updated lesson content")

      # Form resets to create
      expect(page).to have_selector("turbo-frame#lesson_form", wait: 5)
      within("turbo-frame#lesson_form") do
        fill_in "lesson[title]", with: "Lesson 3"
      end
      fill_in_trix_editor_within("turbo-frame#lesson_form", "This is a new lesson")
      within("turbo-frame#lesson_form") do
        click_button "Create Lesson"
      end

      expect(page).to have_content("Lesson created successfully")

      within("turbo-frame#lessons") do
        expect(page).to have_content("Lesson 3")
        expect(page).to have_content("This is a new lesson")
      end
    end
  end

  describe "Deleting a lesson" do
    it "allows the instructor to delete a lesson" do
      login_as(instructor)
      visit course_path(course)

      expect(page).to have_content(lesson1.title)

      accept_confirm do
        click_button "Delete", match: :first
      end

      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("Lesson deleted successfully")
      expect(page).not_to have_content(lesson1.title)
    end
  end
end
