require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get "/user_sessions/new"
    assert_response :success
  end

  test "should get create" do
    post "/user_sessions/", params: { username: users(:one).username, password: "secret"}
    assert_redirected_to user_path(users(:one))
  end

  test "should get destroy" do
    post "/user_sessions", params: { username: users(:one).username, password: "secret"}
    assert_equal flash[:notice], "Login successful"

    delete "/logout"
    assert_redirected_to users_path
    assert_equal flash[:notice], "Logged out!"
  end
end
