require "factory_bot_rails"
require "faker"

include FactoryBot::Syntax::Methods

puts "Creating users..."

instructor1 = create(:user, :instructor,
  email: "instructor1@example.com",
  password: "password",
  password_confirmation: "password",
  role: "instructor"
)

instructor2 = create(:user, :instructor,
  email: "instructor2@example.com",
  password: "password",
  password_confirmation: "password",
  role: "instructor"
)

create(:user,
  email: "student@example.com",
  password: "password",
  password_confirmation: "password"
)

def generate_content
  3.times.map { Faker::Lorem.paragraph(sentence_count: 16) }.join("\n\n")
end

puts "Creating courses and lessons..."

[ instructor1, instructor2 ].each do |instructor|
  5.times do |i|
    course = create(:course,
      title: "#{Faker::Lorem.words(number: 4).join(" ") + " 100#{i + 1}"}".titleize,
      description: Faker::Lorem.sentences(number: 4).join(" "),
      user: instructor,
      status: i % 2 == 0 ? "published" : "draft"
    )

    8.times do |i|
      create(:lesson,
        title: "#{Faker::Lorem.words(number: 4).join(" ") + " #{i + 1}"}".titleize,
        content: generate_content,
        course: course
      )
    end
  end
end
