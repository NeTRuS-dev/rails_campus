class ManagersController < ApplicationController
  append_before_action :check_role

  def index
    @groups = Group.all
    @group_model = Group.new

    @specialties = Specialty.all
    @specialty_model = Specialty.new

    @subject_model = Subject.new
    @subjects = Subject.all

    @skill_model = Skill.new
    @skills = Skill.all
  end

  def create_group
    new_group = Group.new permit_group
    new_group.save
    redirect_to controller: :managers, action: :index, active_tab: :group
  end

  def create_specialty
    new_specialty = Specialty.new permit_specialty
    new_specialty.save
    redirect_to controller: :managers, action: :index, active_tab: :specialty
  end

  def create_subject
    new_subject = Subject.new permit_subject
    new_subject.save
    redirect_to controller: :managers, action: :index, active_tab: :subject
  end

  def create_skill
    new_skill = Skill.new permit_skill
    new_skill.save
    redirect_to controller: :managers, action: :index, active_tab: :skill
  end

  def delete_skill
    skill = Skill.find params[:skill_id]
    skill.destroy unless skill.blank?
    redirect_to controller: :managers, action: :index, active_tab: :skill
  end

  def delete_group
    group = Group.find params[:group_id]
    group.destroy unless group.blank?
    redirect_to controller: :managers, action: :index, active_tab: :group
  end

  def delete_specialty
    specialty = Specialty.find params[:specialty_id]
    specialty.destroy unless specialty.blank?
    redirect_to controller: :managers, action: :index, active_tab: :specialty
  end


  private

  def check_role
    redirect_to controller: :home, action: :index unless current_user.manager?
  end

  def permit_group
    params.require(:group).permit(:name, :code)
  end

  def permit_specialty
    params.require(:specialty).permit(:name, :code, :education_type, :max_courses)
  end

  def permit_subject
    params.require(:subject).permit(:name, :specialty_id)
  end

  def permit_skill
    params.require(:skill).permit(:name)
  end
end
