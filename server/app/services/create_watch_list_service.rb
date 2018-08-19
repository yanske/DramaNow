class CreateWatchListService
  def initialize(user)
    @user = user
  end

  def create
    # TODO: check for cache hits here
    user_dramas = @user.user_dramas.eager_load(:drama, :watching_events).to_a

    # Get latest user_drama per drama
    latest_user_dramas_by_drama = user_dramas.each_with_object({}) do |user_drama, hash|
      drama = user_drama.drama

      unless hash.key?(drama.id) && hash[drama.id].episode_number > user_drama.episode_number
        hash[drama.id] = user_drama
      end
    end

    list = latest_user_dramas_by_drama.map do |_, user_drama|
      latest_watching_event = user_drama.watching_events.last
      if latest_watching_event.still_watching?
        # create_list_object
      elsif user_drama.new_episode?
        # Return next episode info
      end
    end

    list.compact!

    # TODO: cache results
    return list
  end

  private

  def create_list_object(user_drama, next = false)
    {}
  end
end
