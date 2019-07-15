class FetchTodosJob < ApplicationJob
  queue_as :default

  before_enqueue :processing_notification

  # after_perform :ready_notification

  after_perform do |job|
    user_id = job.arguments.first
    user = User.find(user_id)
    ac = ActionController::Base.new()
    todos_html = ac.render_to_string(:template => "users/todos.html.erb", :locals => {:todos => user.todos})

    ActionCable.server.broadcast "web_notifications", {
        message: '<strong>Ready</strong>',
        is_button_disabled: false,
        todos: todos_html
    }
  end

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
        is_button_disabled: true,
    }
  end
end
