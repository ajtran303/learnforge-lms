require "rails_helper"

RSpec.describe "Role-Based Access Control", type: :system do
  let!(:instructor) { FactoryBot.create(:user, email: "instructor@example.com", password: "password", role: "instructor") }
  let!(:learner) { FactoryBot.create(:user, email: "learner@example.com", password: "password", role: "learner") }
  let!(:admin) { FactoryBot.create(:user, email: "admin@example.com", password: "password", role: "admin") }

  before do
    driven_by(:rack_test)
  end

  context "as an instructor" do
    before do
      login_as(instructor)
    end

    it "sees 'Create Course' link" do
      visit dashboard_path
      expect(page).to have_link("Create Course", href: new_course_path)
    end

    it "can access the new course page" do
      visit new_course_path
      expect(page).to have_current_path(new_course_path)
      expect(page).to have_content("Create a new course")
    end

    it "cannot access the admin page" do
      visit admin_path
      expect(page).to have_content("Forbidden")
      expect(page.status_code).to eq(403)
    end
  end

  context "as a learner" do
    before do
      login_as(learner)
    end

    it "does not see 'Create Course' link" do
      visit dashboard_path
      expect(page).not_to have_link("Create Course")
    end

    it "cannot access the new course page" do
      visit new_course_path
      expect(page).to have_content("Forbidden")
      expect(page.status_code).to eq(403)
    end

    it "cannot access the admin page" do
      visit admin_path
      expect(page).to have_content("Forbidden")
      expect(page.status_code).to eq(403)
    end
  end

  context "as an admin" do
    before do
      login_as(admin)
    end

    it "can access the admin panel" do
      visit admin_path
      expect(page).to have_current_path(admin_path)
      expect(page).to have_content("Admin Dashboard")
    end

    it "cannot see 'Create Course' link" do
      visit dashboard_path
      expect(page).not_to have_link("Create Course")
    end
  end

  context "Unauthorized access" do
    it "redirects anonymous user from course page to login page" do
      visit new_course_path
      expect(page).to have_current_path(new_session_path)
      expect(page).to have_content("You must be logged in")
    end

    it "redirects anonymous user from dashboard page to login page" do
      visit dashboard_path
      expect(page).to have_current_path(new_session_path)
      expect(page).to have_content("You must be logged in")
    end

    it "cannot access the admin page" do
      visit admin_path
      expect(page).to have_content("Forbidden")
      expect(page.status_code).to eq(403)
    end
  end
end
