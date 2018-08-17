class WatchingEventsController < ApplicationController
  # POST /users/:user_id/watching_events.json
  def create
    # @user = User.new
    puts params

    respond_to do |format|
      if true
        format.json { render json: "ok", status: :created }
      else
        format.json { render json: "no", status: :unprocessable_entity }
      end
    end
  end

  private

  def watching_event_params
  end
end
