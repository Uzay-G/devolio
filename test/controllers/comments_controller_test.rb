require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    test_login_as(users(:one), "secret")
  end

  test "should get create" do
    assert_difference("Comment.count", 1) do
      post comments_create_url, params: { post: posts(:one), user: users(:one), body: "This is a comment!"}
    end
    assert_response :success
  end

  test "different user cannot update or delete someone else's comment" do
    comment = users(:arch).comments.first

    patch post_path(post), params: { post: { title: "Agar", body: "I shouldn't be allowed to write this post"}}
    patch comment_path(comment)
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to post_path(comment.post)

    delete comment_path(comment)
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to post_path(comment.post)
  end

  test "deleting a comment" do
    comment = comments(:one)

    delete comment_path(comment)

    assert_redirected_to comment.post
    assert_equal flash[:notice], "Comment deleted!"
  end
end
