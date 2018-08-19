require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stub_list_response = [{
      title: "slug-me",
      episode: 2,
      link: "https://www.dramafever.com/drama/123/2/slug-me/",
      img: "www.img.com",
      timestamp: 10,
    }]
  end

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

  test "valid returns not_found if user does not exist" do
    invalid_key = "!!!!!!"
    refute User.exists?(key: invalid_key)

    get valid_users_url, params: { key: invalid_key, format: :json }
    assert_response :not_found
  end

  test "valid returns not_found if user key is not passed" do
    get valid_users_url, params: { format: :json }
    assert_response :not_found
  end

  test "watch list returns list if user key exists" do
    user = users(:one)
    CreateWatchListService.any_instance.expects(:create).returns(@stub_list_response).once
    
    get watch_list_user_url(user.key), params: { format: :json }
    assert_response :ok
    assert_equal response.body, @stub_list_response.to_json
  end

  test "watch list returns not_found if user key does not exist" do
    invalid_key = "!!!!!!"
    refute User.exists?(key: invalid_key)

    get watch_list_user_url(invalid_key), params: { format: :json }
    assert_response :not_found
  end
end
