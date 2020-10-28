class CreateGroup < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, :code, null: false
    end
    create_join_table :subjects, :groups
  end
end
