require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get "/user_sessions/new"
    assert_response :success
  end

  test "should get create" do
    post "/user_sessions/"
    assert_response :success
  end

 # test "should get destroy" do
    #delete user_sessions_destroy_url
  #  assert_response :success
  #end

end
