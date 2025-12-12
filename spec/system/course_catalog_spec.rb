require 'rails_helper'

RSpec.describe "Course Management", type: :system do
  let!(:instructor) { FactoryBot.create(:user, :instructor) }
  let!(:learner) { FactoryBot.create(:user) }
  let!(:course1) { FactoryBot.create(:course, title: "Ruby Basics", description: "Learn Ruby from scratch", user: instructor, status: "published") }
  let!(:course2) { FactoryBot.create(:course, title: "Advanced Ruby", description: "Master advanced Ruby techniques", user: instructor, status: "draft") }

  before do
    driven_by(:rack_test)
  end

  describe "Learner viewing published courses" do
    it "displays only published courses" do
      login_as(learner)
      visit dashboard_path

      expect(page).to have_content(course1.title)
      expect(page).to have_content(course1.description)
      expect(page).to have_content(course1.user.email)

      expect(page).not_to have_content(course2.title)
    end
  end
end
