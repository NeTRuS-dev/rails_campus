class Specialty < ApplicationRecord
  has_many :subjects, dependent: :destroy
  EDUCATION_TYPES = {
      bachelor: 'Бакалавриат',
      specialist: 'Специалитет',
      master: 'Магистратура',
      aspirant: 'Аспирантура',
  }
  enum education_type: EDUCATION_TYPES.keys

  validates :name, :code, :education_type, :max_courses, presence: true

  def humanized_education_type
    EDUCATION_TYPES[education_type.to_sym]
  end
end
