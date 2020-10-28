class Subject < ApplicationRecord
  belongs_to :specialty
  has_many :marks, dependent: :destroy
  has_and_belongs_to_many :groups

  validates :name, presence: true
end
