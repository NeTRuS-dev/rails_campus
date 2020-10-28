class Mark < ApplicationRecord
  belongs_to :subject
  belongs_to :student_info

  validates :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }
end
