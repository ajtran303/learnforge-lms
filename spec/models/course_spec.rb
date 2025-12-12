require "rails_helper"

RSpec.describe Course, type: :model do
  subject { described_class.new(title: "Intro to Ruby", description: "Learn Ruby basics") }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end
end
