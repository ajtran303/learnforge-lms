require "rails_helper"

RSpec.describe "End to End Spec 1", type: :system do
  before do
    driven_by :rack_test
  end

  xdescribe "Instructor workflow" do
    let(:instructor) { FactoryBot.create(:user, :instructor) }
    let(:course1) { FactoryBot.create(:course, user: instructor) }
    let(:lesson1) { FactoryBot.create(:lesson, course: course) }
    let(:lesson2) { FactoryBot.create(:lesson, course: course) }

    it "can edit lessons after creating them" do
      login_as(instructor)

      visit
    end
  end
end
