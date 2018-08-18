class CreateWatchingEventService
  def initialize(params)
    @user_key = params[:user_id]
    @url = params[:url]
    @title = params[:title]
    @site = params[:site]
    @thumbnail = params[:thumbnail]
    @current_episode = params[:currentEpisode]
    @current_time = params[:currentTime]
    @episode_length = params[:episodeLength]
    @latest_episode = params[:latestEpisode]
  end

  # Returns true if create is sucessful, else false
  def create
    @user = User.find_by(key: @user_key)
    return false if @user.nil?

    @drama = Drama.find_by(title: @title, site: @site) || create_drama
    @userdrama = UserDrama.find_by(
      user: @user,
      drama: @drama,
      episode_number: @current_episode
    ) || create_user_drama

    update_latest_episode

    watching_event = WatchingEvent.new(
      user_drama: @userdrama,
      duration: @current_time
    )

    return watching_event.save
  end

  private

  def create_drama
    Drama.create!(
      title: @title,
      site: @site,
      latest_episode: @latest_episode,
      link: @url,
      thumbnail: @thumbnail
    )
  end

  def create_user_drama
    UserDrama.create!(
      user: @user,
      drama: @drama,
      episode_number: @current_episode,
      episode_length: @episode_length
    )
  end

  def update_latest_episode
    if @latest_episode > @drama.latest_episode
      @drama.update!(latest_episode: @latest_episode, latest_episode_update: Time.current)
    end
  end
end
