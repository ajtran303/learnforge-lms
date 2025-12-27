class Lesson < ApplicationRecord
  belongs_to :course

  has_rich_text :content

  has_many :lesson_completions, dependent: :destroy

  has_many :completed_by_users, through: :lesson_completions, source: :user

  validates :title, presence: true
  validates :content, presence: true
end
