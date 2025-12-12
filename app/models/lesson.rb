class Lesson < ApplicationRecord
  belongs_to :course

  validates_presence_of :title, :content
end
