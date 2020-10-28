class StudentsController < ApplicationController
  append_before_action :check_role

  def index
    # @type [User]
    @user = current_user
    @groups = Group.all
    @user.build_student_info unless @user.student_info.present?

    @user.update permit_student_info if request.post?
  end

  def vacancies
    @search_form = VacancySearchForm.new permit_search_params
    @search_form = VacancySearchForm.new unless @search_form.valid?

    if params[:find_for_me].present?
      current_user_skill_ids = current_user.skill_ids
      @vacancies = Vacancy.includes(:skills).references(:skills)
                       .where(['vacancies.wage < ? or vacancies.wage > ?', current_user.student_info.desired_wage.to_i + User::WAGE_RANGE, current_user.student_info.desired_wage.to_i - User::WAGE_RANGE])
                       .or(Vacancy.includes(:skills).references(:skills).where(skills: {id: current_user_skill_ids}))
                       .all
    else
      @vacancies = @search_form.search_results
    end
  end

  private

  def check_role
    redirect_to controller: :home, action: :index unless current_user.student? || current_user.graduate?
  end

  def permit_student_info
    params.require(:user).permit :name, :surname, :patronymic, :birth_date, :group_id, skill_ids: [], student_info_attributes: [:id, :about_me, :full_about_me, :desired_wage, :contact_phone]
  end

  def permit_search_params
    params.fetch(VacancySearchForm.model_name.param_key, {}).permit :title, :key_words, :wage, :position
  end
end
