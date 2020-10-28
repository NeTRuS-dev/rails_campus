class AdminsController < ApplicationController
  append_before_action :check_role

  def index
  end

  private

  def check_role
    redirect_to controller: :home, action: :index unless current_user.admin?
  end
end
