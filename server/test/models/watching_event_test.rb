require 'test_helper'

class WatchingEventTest < ActiveSupport::TestCase
  test "watching event must belong to existing user drama" do
    watching_event = watching_events(:one).dup
    watching_event.user_drama_id = 0
    refute watching_event.save

    assert_includes watching_event.errors.full_messages, "User drama must exist"
  end

  test "duration must be present in watching event" do
    watching_event = watching_events(:one).dup
    watching_event.duration = nil
    refute watching_event.save

    assert_includes watching_event.errors.full_messages, "Duration can't be blank"
  end
end
