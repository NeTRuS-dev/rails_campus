class EmployersController < ApplicationController
  append_before_action :check_role

  def index
    @user = current_user
    @user.build_employer_info unless @user.employer_info.present?

    if request.post?
      @user.update permit_employer_info
    end
  end

  private

  def check_role
    redirect_to controller: :home, action: :index unless current_user.employer?
  end

  def permit_employer_info
    params.require(:user).permit :name, :surname, :patronymic, :birth_date, employer_info_attributes: [:id, :organization_name, :organization_description, :contact_phone]
  end
end
