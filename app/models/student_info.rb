class StudentInfo < ApplicationRecord
  belongs_to :user
  has_many :marks

  validates :about_me, :contact_phone, presence: true
end
