class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons

  validates :title, presence: true
  validates :description, presence: true

  scope :published, -> { where(status: "published") }

  def draft? = status == "draft"
end
