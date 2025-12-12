require "rails_helper"

RSpec.describe "Course Management", type: :system do
  let!(:instructor) { FactoryBot.create(:user, role: "instructor") }

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
end
