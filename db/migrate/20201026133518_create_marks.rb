class CreateMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :marks do |t|
      t.integer :value
      t.references :subject, null: false, foreign_key: true
      t.references :student_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
