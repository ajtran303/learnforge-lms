require "rails_helper"

RSpec.describe Lesson, type: :model do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }

    it { should belong_to :course }
end
