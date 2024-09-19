class NewStockNotifier < ApplicationNotifier
  required_param :title, :message

  deliver_by :action_cable do |config|
    config.channel = "Noticed::NotificationChannel"
    config.stream = -> { recipient }
    config.message = -> { params.merge(user_id: recipient.id) }
  end
end
