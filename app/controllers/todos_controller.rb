class TodosController < ApplicationController

  def create
    # disable the button, and display "in-progress"
    ActionCable.server.broadcast "web_notifications", {
      message: '<p>hello world!</p>'
    }

    # run the job


    # after job is completed, enable button, and display "completed"
  end

end
