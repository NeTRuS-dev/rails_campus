class CreateSpecialty < ActiveRecord::Migration[6.0]
  def change
    create_table :specialties do |t|
      t.string :name, :code, null: false
      t.string :education_type, default: :bachelor
      t.integer :max_courses, default: 4
    end
  end
end
