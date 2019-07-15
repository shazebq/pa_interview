class FetchTodosJob < ApplicationJob
  queue_as :default

  after_perform :notify

  def perform(*args)
    # Do something later
    sleep 3
  end

  private

  def notify
    puts "**** Active job completed!"
  end
end
