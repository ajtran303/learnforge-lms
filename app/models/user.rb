class User < ApplicationRecord
  has_secure_password

  has_many :courses, dependent: :destroy
  has_and_belongs_to_many :enrolled_courses,
    class_name: "Course",
    join_table: "courses_users",
    foreign_key: "user_id",
    association_foreign_key: "course_id"

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def instructor? = role == "instructor"
  def learner? = role == "learner"
end
