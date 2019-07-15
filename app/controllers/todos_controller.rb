class TodosController < ApplicationController

  def create
    # disable the button, and display "in-progress"
    # ActionCable.server.broadcast "web_notifications", {
    #   message: '<p>hello world!</p>'
    # }

    # run the job
    # FetchTodosJob.perform_later

    # after job is completed, enable button, and display "completed"

    response = HTTParty.get("https://jsonplaceholder.typicode.com/todos?userId=#{params['userId']}", format: :plain)
    parsed_response = JSON.parse response, symbolize_names: true
    todos = parsed_response.map { |todo| {title: todo[:title], completed: todo[:completed], user_id: todo[:userId]}}
    todos.each do |todo|
      Todo.find_or_create_by(todo)
    end
  end

end
