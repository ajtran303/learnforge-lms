FactoryBot.define do
  factory :course do
    sequence(:title) { |n| "Ruby 10#{n}" }
    description { "Learn Ruby basics" }
  end
end
