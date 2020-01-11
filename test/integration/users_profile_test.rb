require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:one)
  end

  test "profile display" do
    get user_path(@user)
    assert_select 'title', "#{@user.username} | Devolio"
    assert_select 'h1', text: @user.username
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination'
  end
end