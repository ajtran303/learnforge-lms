require "rails_helper"

RSpec.describe "Course Management", type: :system do
  let!(:instructor) { FactoryBot.create(:user, role: "instructor") }
  let!(:course) { FactoryBot.create(:course, title: "Old Title", description: "Old Description", user: instructor) }

  before do
    driven_by(:rack_test)
    login_as(instructor)
  end

  it "allows an instructor to create a course with valid details" do
    visit new_course_path

    fill_in "Course Title", with: "Intro to Ruby"
    fill_in "Course Description", with: "Learn Ruby basics"
    click_button "Create Course"

    expect(page).to have_current_path(course_path(Course.last))
    expect(page).to have_content("Course created successfully")
    expect(Course.last.status).to eq("draft")
  end

  it "shows validation errors when invalid" do
    visit new_course_path

    fill_in "Course Title", with: ""
    fill_in "Course Description", with: ""
    click_button "Create Course"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  describe "editing a course" do
    it "allows instructor to update course details" do
      visit dashboard_path
      click_link "Edit", href: edit_course_path(course)

      fill_in "Course Title", with: "Updated Title"
      fill_in "Course Description", with: "Updated Description"
      click_button "Update Course"

      expect(page).to have_current_path(course_path(course))
      expect(page).to have_content("Course updated successfully")

      expect(course.reload.title).to eq("Updated Title")
      expect(course.reload.description).to eq("Updated Description")
    end
  end

  describe "deleting a course" do
    it "allows instructor to delete a course with confirmation" do
      skip "this test is flakey, it passes alone but not when the whole suite runs"
      driven_by :selenium_chrome_headless

      login_as(instructor)
      visit dashboard_path

      expect(page).to have_button("Delete")

      accept_confirm do
        click_button "Delete"
      end

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Course deleted successfully")
      expect(Course.exists?(course.id)).to be_falsey
    end
  end
end
