class TodosController < ApplicationController

  def index
    # render(json: {message: 'hello world'}, :status => :ok)
    ActionCable.server.broadcast "web_notifications", {
      message: '<p>hello world!</p>'
    }
  end

end
