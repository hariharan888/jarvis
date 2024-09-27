# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def show
    if current_user
      render json: {
        status: {
          code: 200,
          message: "success",
        },
        data: {
          token: request.headers["Authorization"].to_s.split(" ").last,
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
        },
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: "Couldn't find an active session.",
        },
      }, status: :unauthorized
    end
  end

  def generate_token
    if current_user
      token = current_user.generate_secondary_token

      render json: {
        status: {
          code: 200,
          message: "success",
        },
        data: {
          token:,
        },
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: "Couldn't find an active session.",
        },
      }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opt = {})
    @token = request.env["warden-jwt_auth.token"]
    headers["Authorization"] = @token
    current_user.generate_secondary_token

    render json: {
      status: {
        code: 200,
        message: "Logged in successfully.",
      },
      data: {
        token: @token,
        user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
      },
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(request.headers["Authorization"].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload["sub"])
      # logout from other services where secondary_token is used
      current_user.update(secondary_token: nil)
    end

    if current_user
      render json: {
        status: {
          code: 200,
          message: "Logged out successfully.",
        },
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: "Couldn't find an active session.",
        },
      }, status: :unauthorized
    end
  end
end
