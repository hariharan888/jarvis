# app/channels/global_notification_channel.rb
class GlobalNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for "global_notifications"
    logger.debug "User #{current_user.id} subscribed to GlobalNotificationChannel"
  end

  def unsubscribed
    logger.debug "User #{current_user.id} unsubscribed from GlobalNotificationChannel"
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    logger.debug "Received data: #{data.inspect} from User #{current_user.id}"
    # Handle received data
  end
end
