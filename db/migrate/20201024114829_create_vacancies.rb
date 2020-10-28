class CreateVacancies < ActiveRecord::Migration[6.0]
  def change
    create_table :vacancies do |t|
      t.string :title, null: false
      t.text :description
      t.integer :wage
      t.string :position

      t.references :employer_info
      t.timestamps
    end
  end
end
