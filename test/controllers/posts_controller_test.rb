require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    test_login_as(@user, "secret")
  end
  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should show post" do
    get post_path(posts(:most_recent))
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: { post: { title: "This is a post!", body: "code blocks" } }
    end
  end

  test "create and new post should be restricted to logged in user" do
    delete "/logout"
    assert_equal flash[:notice], "Logged out!"

    get new_post_url
    assert_redirected_to "/login" 
    assert_equal flash[:error], "Please login first"

    assert_difference("Post.count", 0) do
      post posts_url, params: { post: { title: "This is a post!", body: "code blocks" } }
    end

    assert_redirected_to "/login"
    assert_equal flash[:error], "Please login first"
  end
end
