require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should intialize user with key length 6" do
    user = User.new
    assert_predicate user.key, :present?
    assert_equal user.key.length, 6
    user.save!
  end

  test "should not create user with non unique key" do
    user_one = User.create!
    user_two = User.new
    user_two.key = user_one.key

    refute user_two.save
    assert_equal user_two.errors.full_messages, ["Key has already been taken"]
  end
end
