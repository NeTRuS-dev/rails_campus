class EmployerInfo < ApplicationRecord
  belongs_to :user
  has_many :vacancies, inverse_of: :employer_info

  accepts_nested_attributes_for :vacancies

  validates :contact_phone, :organization_name, presence: true
end
