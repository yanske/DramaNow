class CreateWatchListService
  def initialize(user)
    @user = user
  end

  def create
    watched_dramas = @user.user_dramas.eager_load(:drama, :watching_events).to_a

    # Get latest user_drama per drama
    latest_user_dramas_by_drama = watched_dramas.each_with_object({}) do |user_drama, hash|
      drama = user_drama.drama

      unless hash.key?(drama.id) && hash[drama.id].episode_number > user_drama.episode_number
        hash[drama.id] = user_drama
      end
    end

    list = latest_user_dramas_by_drama.map do |_, user_drama|
      if user_drama.latest_watching_event.still_watching?
        create_list_object(user_drama)
      elsif user_drama.new_episode_available?
        create_list_object(user_drama, true)
      end
    end

    list.compact
  end

  private

  def create_list_object(user_drama, next_episode = false)
    episode_number = next_episode ? user_drama.episode_number + 1 : user_drama.episode_number
    link = user_drama.drama.link_to_episode(episode_number)
    timestamp = next_episode ? 0 : user_drama.latest_watching_event.duration

    {
      title: user_drama.drama.pretty_title,
      episode: episode_number,
      link: link,
      img: user_drama.drama.thumbnail,
      timestamp: timestamp,
    }
  end
end
