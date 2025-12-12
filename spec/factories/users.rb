FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "learner" }

    trait :instructor do
      role { "instructor" }
    end
  end
end
