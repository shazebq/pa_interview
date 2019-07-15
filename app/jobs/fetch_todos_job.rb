class FetchTodosJob < ApplicationJob
  queue_as :default

  before_enqueue :processing_notification

  after_perform :ready_notification

  def perform(user_id)
    response = HTTParty.get("https://jsonplaceholder.typicode.com/todos?userId=#{user_id}", format: :plain)
    parsed_response = JSON.parse response, symbolize_names: true
    todos = parsed_response.map { |todo| {title: todo[:title], completed: todo[:completed], user_id: todo[:userId]}}
    todos.each do |todo|
      Todo.find_or_create_by(todo)
    end
    sleep 2
  end

  private

  def ready_notification
    ActionCable.server.broadcast "web_notifications", {
        message: '<strong>Ready</strong>',
        is_button_disabled: false
    }
  end

  def processing_notification
    ActionCable.server.broadcast "web_notifications", {
        message: '<strong>Processing...</strong>',
        is_button_disabled: true
    }
  end
end
