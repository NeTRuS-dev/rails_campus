class Skill < ApplicationRecord
  has_and_belongs_to_many :students, class_name: 'User', foreign_key: 'skill_id', association_foreign_key: "user_id"
  has_and_belongs_to_many :vacancies

  validates :name, presence: true
end
