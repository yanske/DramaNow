require 'test_helper'

class WatchingEventsControllerTest < ActionDispatch::IntegrationTest
  test "create does not respond to html" do
    assert_raise ActionController::UnknownFormat do
      post user_watching_events_url("123"), params: { format: :html }
    end
  end

  test "return created if watching event created" do
    CreateWatchingEventService.any_instance.expects(:create).returns(true).once
    post user_watching_events_url("123"), params: { format: :json }
    assert_response :created
  end

  test "return unprocessable if watching event creation failed" do
    CreateWatchingEventService.any_instance.expects(:create).returns(false).once
    post user_watching_events_url("123"), params: { format: :json }
    assert_response :unprocessable_entity
  end
end
