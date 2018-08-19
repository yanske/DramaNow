require 'test_helper'

class CreateWatchingEventServiceTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @drama = dramas(:one)
    @userdrama = user_dramas(:one)
  
    @create_watching_event_params = {
      user_id: @user.key,
      url: "www.dummy.link",
      title: @drama.title,
      site: @drama.site,
      thumbnail: @drama.thumbnail,
      currentEpisode: @userdrama.episode_number,
      currentTime: 1,
      episodeLength: @userdrama.episode_length,
      latestEpisode: @drama.latest_episode
    }
  end

  test "creates a watching event with existing drama and userdrama " do
    create_watching_event = CreateWatchingEventService.new(@create_watching_event_params)

    assert_no_difference 'Drama.count' do 
      assert_no_difference 'UserDrama.count' do
        assert_difference 'WatchingEvent.count', 1 do
          assert create_watching_event.create
        end
      end 
    end

    event = WatchingEvent.unscoped.last
    assert_equal event.user_drama_id, @userdrama.id
    assert_equal event.duration, @create_watching_event_params[:currentTime]
  end

  test "creates a drama and userdrama if no drama present" do
    @drama.destroy!
    create_watching_event = CreateWatchingEventService.new(@create_watching_event_params)

    assert_difference 'Drama.count', 1 do 
      assert_difference 'UserDrama.count', 1 do
        assert_difference 'WatchingEvent.count', 1 do
          assert create_watching_event.create
        end
      end 
    end

    new_drama = Drama.last
    assert_equal new_drama.title, @create_watching_event_params[:title]
    assert_equal new_drama.site, @create_watching_event_params[:site]
    refute_nil new_drama.latest_episode_update
  end

  test "does not create anything if user does not exist" do
    @user.destroy!
    create_watching_event = CreateWatchingEventService.new(@create_watching_event_params)

    assert_no_difference 'Drama.count' do 
      assert_no_difference 'UserDrama.count' do
        assert_no_difference 'WatchingEvent.count' do
          refute create_watching_event.create
        end
      end 
    end
  end

  test "creates a userdrama if no userdrama present" do
    @userdrama.destroy!
    create_watching_event = CreateWatchingEventService.new(@create_watching_event_params)

    assert_no_difference 'Drama.count' do 
      assert_difference 'UserDrama.count', 1 do
        assert_difference 'WatchingEvent.count', 1 do
          assert create_watching_event.create
        end
      end 
    end

    new_user_drama = UserDrama.unscoped.last
    assert_equal new_user_drama.drama_id, @drama.id
    assert_equal new_user_drama.user_id, @user.id
    assert_equal new_user_drama.episode_number, @create_watching_event_params[:currentEpisode]
  end
end
