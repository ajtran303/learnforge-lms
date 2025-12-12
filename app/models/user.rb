class User < ApplicationRecord
  has_secure_password

  has_many :courses, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def instructor? = role == "instructor"
end
