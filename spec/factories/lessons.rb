FactoryBot.define do
  factory :lesson do
    title { "Sample Lesson Title" }
    content { "Sample lesson content" }
    course
  end
end
