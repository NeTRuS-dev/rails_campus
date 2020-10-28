class AddFieldsToUserModel < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, default: :student
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :patronymic, :string
    add_column :users, :birth_date, :date

    add_reference :users, :group
  end
end
