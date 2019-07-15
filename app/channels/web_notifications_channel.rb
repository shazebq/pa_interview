class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_notifications"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
