class User < ApplicationRecord
  WAGE_RANGE = 10_000
  ROLE_NAMES = {
      student: 'Студент',
      graduate: 'Выпускник',
      employer: 'Работодатель',
      admin: 'Администратор',
      manager: 'Менеджер',
  }

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_one :student_info, inverse_of: :user, dependent: :destroy, autosave: true
  has_one :employer_info, inverse_of: :user, dependent: :destroy, autosave: true
  has_many :marks, through: :student_info, dependent: :destroy
  accepts_nested_attributes_for :student_info
  accepts_nested_attributes_for :employer_info

  belongs_to :group, optional: true
  has_and_belongs_to_many :skills, autosave: true
  enum role: ROLE_NAMES.keys

  validates_associated :skills, :student_info, if: ->(user) { user.student? || user.graduate? }
  validates_associated :employer_info, if: ->(user) { user.employer? }

  def full_name
    "#{surname} #{name} #{patronymic}"
  end
end
