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

def generate_rich_content
  paragraphs = 3.times.map { "<p>#{Faker::Lorem.paragraph(sentence_count: 8)}</p>" }

  # Add some formatting variety
  intro = "<h2>Overview</h2>"
  bullet_points = "<ul>" + 3.times.map { "<li>#{Faker::Lorem.sentence}</li>" }.join + "</ul>"

  [intro, paragraphs[0], bullet_points, "<h2>Details</h2>", paragraphs[1], paragraphs[2]].join("\n")
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
        content: generate_rich_content,
        course: course
      )
    end
  end
end
