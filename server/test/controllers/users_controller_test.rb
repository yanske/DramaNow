require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create does not respond to html" do
    assert_raise ActionController::UnknownFormat do
      post users_url, params: { format: :html }
    end
  end

  test "create creates user and respond with key" do
    assert_difference 'User.count', 1 do
      post users_url, params: { format: :json }
      assert_response :success
    end

    new_key = User.last.key
    assert_equal new_key, response.body
  end

  test "valid does not respond to html" do
    assert_raise ActionController::UnknownFormat do
      get valid_users_url, params: { key: "123456", format: :html }
    end
  end

  test "valid returns ok if user exists" do
    user_one = users(:one)

    get valid_users_url, params: { key: user_one.key, format: :json }
    assert_response :ok
  end

  test "valid returns unauthorized if user does not exist" do
    invalid_key = "!!!!!!"
    refute User.exists?(key: invalid_key)

    get valid_users_url, params: { key: invalid_key, format: :json }
    assert_response :unauthorized
  end
end
