class TodosController < ApplicationController

  def create
    # disable the button, and display "in-progress"

    # run the job
    FetchTodosJob.perform_later(params['userId'])

    # after job is completed, enable button, and display "completed"
  end

end
