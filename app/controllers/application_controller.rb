# @!method authenticate_user!
# @!method user_signed_in?
# @return [Boolean]
# @!method current_user
# @return [User]
# @!method user_session
# @return [Hash]
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname patronymic birth_date role])
  end
end
