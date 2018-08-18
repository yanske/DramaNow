class WatchingEventsController < ApplicationController
  # POST /users/:user_id/watching_events.json
  def create
    create_watching_event = CreateWatchingEventService.new(watching_event_params)
    respond_to do |format|
      if create_watching_event.create
        format.json { render json: "Success", status: :created }
      else
        format.json { render json: "Failure to create watching event", status: :unprocessable_entity }
      end
    end
  end

  private

  def watching_event_params
    params.permit(
      :user_id,
      :url,
      :title,
      :site,
      :thumbnail,
      :currentEpisode,
      :currentTime,
      :episodeLength,
      :latestEpisode
    ).to_h || {}
  end
end
