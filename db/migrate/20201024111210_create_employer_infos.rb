class CreateEmployerInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :employer_infos do |t|
      t.string :organization_name
      t.text :organization_description

      t.string :contact_phone
      t.references :user
      t.timestamps
    end
    add_column :student_infos, :contact_phone, :string
  end
end
