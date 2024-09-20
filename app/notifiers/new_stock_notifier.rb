class NewStockNotifier < ApplicationNotifier
  required_param :title, :message
  recipients -> { User.kept }

  deliver_by :action_cable do |config|
    config.channel = "GlobalNotificationChannel"
    config.stream = "global_notifications"
    config.message = -> { params.merge(user_id: recipient.id) }
  end
end
