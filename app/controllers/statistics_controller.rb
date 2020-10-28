class StatisticsController < ApplicationController
  before_action :check_role

  def index
    @students = User.includes(:skills, student_info: {marks: :subject}).where(role: :student).or(User.includes(:skills, student_info: {marks: :subject}).where(role: :graduate))
                    .merge(User.includes(:skills, student_info: {marks: :subject}).references(:skills, student_info: {marks: :subject}).where('student_infos.id is not null')).all
  end

  def average
    @students = User.joins(student_info: {marks: :subject})
                    .select('users.id, users.email,users.name,users.surname,users.patronymic', 'subjects.name as subject_name', 'AVG(marks.value) as avg_marks_value')
                    .group('users.id, users.email,users.name,users.surname,users.patronymic', 'subjects.name').all
  end

  private

  def check_role
    redirect_to controller: :home, action: :index unless current_user.manager?
  end
end
