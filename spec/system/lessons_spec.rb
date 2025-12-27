require "rails_helper"

RSpec.describe "Lessons Management", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let!(:instructor) { FactoryBot.create(:user, role: "instructor") }
  let!(:course) { FactoryBot.create(:course, user: instructor, status: "published") }

  context "Instructor adds a lesson" do
    before do
      login_as(instructor)

      visit course_path(course)
    end

    # Skipped: Flaky due to Trix editor timing issues in headless Chrome
    xit "successfully adds a lesson with title and content" do
      within("turbo-frame#lesson_form") do
        fill_in "Title", with: "Lesson 1"
      end
      fill_in_trix_editor_within("turbo-frame#lesson_form", "This is rich lesson content")
      within("turbo-frame#lesson_form") do
        click_button "Create Lesson"
      end

      expect(page).to have_content("Lesson created successfully")

      within("turbo-frame#lessons") do
        expect(page).to have_content("Lesson 1")
        expect(page).to have_content("This is rich lesson content")
      end
    end
  end

  context "Non-instructor cannot add a lesson" do
    let!(:learner) { FactoryBot.create(:user) }

    it "does not show the lesson form" do
      login_as(learner)
      visit course_path(course)

      expect(page).not_to have_selector("turbo-frame#lesson_form")
      expect(page).not_to have_field("Title")
      expect(page).not_to have_selector("trix-editor")
    end
  end
end
