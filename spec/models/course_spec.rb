require "rails_helper"

RSpec.describe Course, type: :model do
  subject { described_class.new(title: "Intro to Ruby", description: "Learn Ruby basics") }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "defaults" do
    it "has a default status of 'draft' before saving" do
      course = FactoryBot.build(:course)
      expect(course.status).to eq("draft")
    end

    it "has a default status of 'draft' after saving" do
      course = FactoryBot.create(:course)
      expect(course.status).to eq("draft")
    end
  end
end
