require 'test_helper'

class UserDramaTest < ActiveSupport::TestCase
  test "user drama must belong to an existing user" do
    user_dramas(:one).user.destroy!

    userdrama = user_dramas(:one).dup
    refute userdrama.save
    assert_includes userdrama.errors.full_messages, "User must exist"
  end

  test "user drama must belong to an existing drama" do
    user_dramas(:one).drama.destroy!

    userdrama = user_dramas(:one).dup
    refute userdrama.save
    assert_includes userdrama.errors.full_messages, "Drama must exist"
  end

  test "user drama validates uniqueness on user, drama and episode number" do
    userdrama = user_dramas(:one).dup
    refute userdrama.save
    assert_includes userdrama.errors.full_messages, "User already watching this episode"
  end

  test "new episode returns true if new episode is available" do
    userdrama = user_dramas(:one)
    drama = userdrama.drama
    drama.update!(latest_episode: userdrama.episode_number + 1)

    assert_predicate userdrama.reload, :new_episode_available?
  end

  test "new episode returns false if new episode is not available" do
    userdrama = user_dramas(:one)
    drama = userdrama.drama

    drama.update!(latest_episode: userdrama.episode_number)
    refute_predicate userdrama.reload, :new_episode_available?

    drama.update!(latest_episode: userdrama.episode_number - 1)
    refute_predicate userdrama.reload, :new_episode_available?
  end
end
