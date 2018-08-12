require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create does not respond to html requests" do
    assert_raise ActionController::UnknownFormat do
      post users_url, params: { format: :html }
    end
  end

  test "should create user and respond with key" do
    assert_difference 'User.count', 1 do
      post users_url, params: { format: :json }
      assert_response :success
    end

    new_key = User.last.key
    assert_equal new_key, response.body
  end
end
