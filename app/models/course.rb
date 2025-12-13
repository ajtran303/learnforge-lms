class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_and_belongs_to_many :enrolled_users,
    class_name: "User",
    join_table: "courses_users",
    foreign_key: "course_id",
    association_foreign_key: "user_id"

  validates :title, presence: true
  validates :description, presence: true

  scope :published, -> { where(status: "published") }

  def draft? = status == "draft"
end
