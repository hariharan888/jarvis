module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", "User #{current_user.id}"
      start_token_expiry_check
    end

    def disconnect
      logger.add_tags "ActionCable", "User #{current_user.id} disconnected"
      stop_token_expiry_check
    end

    private

    def stop_token_expiry_check
      @token_expiry_timer&.stop
    end

    protected

    def find_verified_user
      reject_unauthorized_connection unless request.params["token"].present?

      user = User.find_by(secondary_token: request.params["token"])

      reject_unauthorized_connection unless user

      user
    end

    def start_token_expiry_check
      @token_expiry_timer = periodically(1.minute) do
        if current_user.secondary_token.nil?
          logger.info "Token expired for User #{current_user.id}, disconnecting..."
          close
        end
      end
    end
  end
end
