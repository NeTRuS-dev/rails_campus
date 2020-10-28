class Vacancy < ApplicationRecord
  belongs_to :employer_info

  has_and_belongs_to_many :skills

  validates :title, :position, :wage, presence: true
end
