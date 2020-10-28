class Group < ApplicationRecord
  has_and_belongs_to_many :subjects

  validates :name, :code, presence: true
end
