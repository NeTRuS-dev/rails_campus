class CreateSkillUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :skills, :users
  end
end
