require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:arch)
    test_login_as(@user, "secret")
  end

  test "should get new" do
    delete "/logout"
    get new_user_url
    assert_response :success
  end

  test "should not be able to access login restricted views" do
    delete logout_url
    get edit_user_url(@user)
    assert_redirected_to "/login"
    delete user_url(@user)
    assert_redirected_to "/login"
  end 

  test "should create user" do
    delete "/logout"
    assert_equal flash[:notice], "Logged out!"

    assert_difference('User.count') do
      post users_url, params: { user: { email: "sda2@as.com", password: "password", password_confirmation: "password", username: "xasaaa"} }
    end
   # assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { crypted_password: @user.crypted_password, email: @user.email, salt: @user.salt } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
