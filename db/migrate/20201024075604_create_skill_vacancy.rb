class CreateSkillVacancy < ActiveRecord::Migration[6.0]
  def change
    create_join_table :skills, :vacancies
  end
end
