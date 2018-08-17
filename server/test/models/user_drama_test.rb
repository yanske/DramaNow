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
end
