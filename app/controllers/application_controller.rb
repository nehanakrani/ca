class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Devise::Controllers::Helpers
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :admin])
  end

  def verify_admin
    render json: { message: 'Access denied' }, status: :unauthorized unless @current_user.admin
  end
end
