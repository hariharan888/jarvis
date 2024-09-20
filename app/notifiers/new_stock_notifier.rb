class NewStockNotifier < ApplicationNotifier
  required_param :title, :message
  recipients -> { User.kept }

  deliver_by :action_cable do |config|
    config.channel = "NotificationChannel"
    config.stream = -> { recipient }
    config.message = -> { params.merge(user_id: recipient.id) }
  end
end
