class FetchTodosJob < ApplicationJob
  queue_as :default

  after_perform :notify

  def perform(*args)
    # Do something later
    sleep 3
  end

  private

  def notify
    ActionCable.server.broadcast "web_notifications", {
        message: '<p>Job Completed!!!</p>'
    }
  end
end
