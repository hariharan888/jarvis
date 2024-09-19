class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user
  #   if request.headers["Authorization"].present?
  #     token = request.headers["Authorization"].split.last
  #     payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first

  #     @current_user ||= User.kept.find_by(id: payload["sub"])
  #   end
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
