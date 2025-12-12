class Course < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  def draft? = status == "draft"
end
