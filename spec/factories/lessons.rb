FactoryBot.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    course
  end
end
