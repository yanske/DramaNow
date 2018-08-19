require 'test_helper'

class CreateWatchListServiceTest < ActiveSupport::TestCase
  setup do
    @user = User.create!
    @service = CreateWatchListService.new(@user)

    @watching_event_service_params_episode_one = {
      user_id: @user.key,
      url: "https://www.dramafever.com/drama/123/1/slug-me/",
      title: "slug-me",
      site: "dramafever",
      thumbnail: "www.img.com",
      currentEpisode: 1,
      currentTime: 1,
      episodeLength: 1.hours.to_i,
      latestEpisode: 30
    }

    @watching_event_service_params_episode_two = {
      user_id: @user.key,
      url: "https://www.dramafever.com/drama/123/2/slug-me/",
      title: "slug-me",
      site: "dramafever",
      thumbnail: "www.img.com",
      currentEpisode: 2,
      currentTime: 10,
      episodeLength: 1.hours.to_i,
      latestEpisode: 30
    }

    @expected_list = [{
      title: "slug-me",
      episode: 2,
      link: "https://www.dramafever.com/drama/123/2/slug-me/",
      img: "www.img.com",
      timestamp: 10,
    }]
  end

  test "returns episodes currently being watched" do
    # Setup: 2 events for episode one, finished watching, 1 event for episode two
    CreateWatchingEventService.new(@watching_event_service_params_episode_one).create
    @watching_event_service_params_episode_one[:currentTime] = 1.hours.to_i
    CreateWatchingEventService.new(@watching_event_service_params_episode_one).create
    CreateWatchingEventService.new(@watching_event_service_params_episode_two).create

    assert_equal @service.create, @expected_list
  end

  test "does not returns episodes that are not available" do
    # Setup: 1 event at end of episode one, drama only has 1 episode
    @watching_event_service_params_episode_one[:currentTime] = 1.hours.to_i
    @watching_event_service_params_episode_one[:latestEpisode] = 1
    CreateWatchingEventService.new(@watching_event_service_params_episode_one).create

    assert_equal @service.create, []
  end

  test "returns new episodes that are available" do
    # Setup: 1 event at end of epside one, drama has more than 1 episode
    @watching_event_service_params_episode_one[:currentTime] = 1.hours.to_i
    CreateWatchingEventService.new(@watching_event_service_params_episode_one).create

    @expected_list.first[:timestamp] = 0
    assert_equal @service.create, @expected_list
  end
end
