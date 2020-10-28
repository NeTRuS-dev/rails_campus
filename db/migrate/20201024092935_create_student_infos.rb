class CreateStudentInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :student_infos do |t|
      t.text :about_me
      t.text :full_about_me
      t.bigint :desired_wage

      t.references :user
      t.timestamps
    end
  end
end
