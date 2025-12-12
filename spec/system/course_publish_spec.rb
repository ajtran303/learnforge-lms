require "rails_helper"

RSpec.describe "Course Publish Toggle",  type: :system do
  let!(:instructor) { FactoryBot.create(:user, role: "instructor") }
  let!(:learner) { FactoryBot.create(:user, role: "learner") }
  let!(:course) { FactoryBot.create(:course, user: instructor, status: "draft") }

  before do
    driven_by(:rack_test)
  end

  context "as an instructor" do
    before do
      login_as(instructor)
    end

    it "can publish a draft course" do
      visit course_path(course)

      click_button "Publish"

      expect(page).to have_content("Course published successfully")
      expect(course.reload.status).to eq("published")
    end

    it "can unpublish a published course" do
      course.update!(status: "published")

      visit course_path(course)

      click_button "Unpublish"

      expect(page).to have_content("Course reverted to draft")
      expect(course.reload.status).to eq("draft")
    end
  end

  context "as a learner" do
    before do
      login_as(learner)
    end

    it "only sees published courses" do
      draft_course = FactoryBot.create(:course, user: instructor, status: "draft")
      published_course = FactoryBot.create(:course, user: instructor, status: "published")

      visit dashboard_path

      expect(page).not_to have_content(draft_course.title)
      expect(page).to have_content(published_course.title)
    end
  end
end
