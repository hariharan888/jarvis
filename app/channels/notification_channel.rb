class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    logger.debug "User #{current_user.id} subscribed to NotificationChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    logger.debug "User #{current_user.id} unsubscribed to NotificationChannel"
  end

  def receive(data)
    logger.debug "Received data: #{data.inspect} from User #{current_user.id}"
    # Handle received data
  end

  def broadcast(data)
    logger.debug "Broadcasting NotificationChannel data: #{data.inspect} to User #{current_user.id}"
    NotificationChannel.broadcast_to(current_user, data)
  end
end
