module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", "User #{current_user.id}"
    end

    protected

    def find_verified_user
      if request.params["token"].present?
        payload = JWT.decode(request.params["token"], Rails.application.credentials.devise_jwt_secret_key!).first
        User.kept.find_by(id: payload["sub"])
      else
        reject_unauthorized_connection
      end
    end
  end
end
