class HomeController < ApplicationController
  def index
    if current_user.admin?
      redirect_to controller: :admins, action: :index
    elsif current_user.manager?
      redirect_to controller: :managers, action: :index
    elsif current_user.employer?
      redirect_to controller: :employers, action: :index
    else
      redirect_to controller: :students, action: :index
    end
  end
end
