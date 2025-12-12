class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons

  validates :title, presence: true
  validates :description, presence: true

  def draft? = status == "draft"
end
