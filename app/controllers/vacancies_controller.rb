class VacanciesController < ApplicationController
  before_action :check_role
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  # GET /vacancies
  # GET /vacancies.json
  def index
    @vacancies = current_user.employer_info.vacancies.all
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    if @vacancy.present?
      @matched_users = (User.includes(:student_info, :skills).references(:student_infos, :skills).where(role: :student)
                            .or(User.includes(:student_info, :skills).references(:student_infos, :skills).where(role: :graduate)))
                           .merge(User.includes(:student_info, :skills).references(:student_infos, :skills)
                                      .where(['student_infos.desired_wage < ? or student_infos.desired_wage > ?', @vacancy.wage.to_i + User::WAGE_RANGE, @vacancy.wage.to_i - User::WAGE_RANGE])
                                      .or(User.includes(:student_info, :skills).references(:student_infos, :skills).where(skills: {id: @vacancy.skill_ids})))
                           .all
    end
  end

  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new
  end

  # GET /vacancies/1/edit
  def edit
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    # @type [Vacancy] @vacancy
    @vacancy = current_user.employer_info.vacancies.build(vacancy_params)

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  # PATCH/PUT /vacancies/1.json
  def update
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: 'Vacancy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacancy
    @vacancy = current_user.employer_info.vacancies.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacancy_params
    params.require(:vacancy).permit(:title, :description, :wage, :position, skill_ids: [])
  end

  def check_role
    redirect_to controller: :home, action: :index unless current_user.employer?
    unless current_user.employer_info.present?
      flash[:alert] = 'Заполните профиль организации'
      redirect_to controller: :employers, action: :index
    end
  end
end
