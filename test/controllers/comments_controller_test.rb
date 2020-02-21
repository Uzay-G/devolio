require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    test_login_as(users(:one), "secret")
  end

  test "should get create" do
    assert_difference("Comment.count", 1) do
      post "/posts/#{Post.first.url}/comments", params: { comment: { body: "This is a comment!"} }, xhr: true
    end
    assert_response :success
  end

  test "different user cannot update or delete someone else's comment" do
    comment = users(:arch).comments.first

    patch "/posts/#{comment.post.url}/comments/#{comment.id}", params: { comment: { body: "I shouldn't be allowed to write this comment"} }
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to post_path(comment.post)

    delete "/posts/#{comment.post.url}/comments/#{comment.id}"
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to post_path(comment.post)
  end

  test "deleting a comment" do
    comment = comments(:one)

    assert_difference("Comment.count", -1) do
      delete "/posts/#{comment.post.url}/comments/#{comment.id}"
    end
    assert_redirected_to comment.post
    assert_equal flash[:notice], "Comment deleted!"
  end
end
