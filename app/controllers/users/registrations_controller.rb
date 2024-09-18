# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      @token = request.env["warden-jwt_auth.token"]
      headers["Authorization"] = @token

      render json: {
        status: { code: 200, message: "Signed up successfully." },
        data: { user: UserSerializer.new(resource).serializable_hash[:data][:attributes], token: @token },
      }
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" },
      }, status: :unprocessable_entity
    end
  end
end
