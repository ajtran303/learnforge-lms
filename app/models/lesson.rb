class Lesson < ApplicationRecord
  belongs_to :course

  has_many :lesson_completions, dependent: :destroy

  has_many :completed_by_users, through: :lesson_completions, source: :user

  validates_presence_of :title, :content
end
