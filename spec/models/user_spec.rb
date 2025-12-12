require "rails_helper"

RSpec.describe User, type: :model do
  subject { described_class.new(email: "learner@example.com", password: "password", password_confirmation: "password") }

  describe "associations" do
    it { should have_and_belong_to_many(:enrolled_courses).class_name('Course').join_table('courses_users') }
    it { should have_many(:courses).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_length_of(:password).is_at_least(6) }

    it "requires matching password confirmation" do
      subject.password_confirmation = "mismatch"
      expect(subject).not_to be_valid
      expect(subject.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
