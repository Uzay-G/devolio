require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    test_login_as(users(:one), "secret")
  end

  test "should get create" do
    assert_difference("Comment.count", 1) do
      post comments_url, params: { comment: { post_id: Post.first.id, body: "This is a comment!"} }
    end
    assert_response :success
  end

  test "different user cannot update or delete someone else's comment" do
    comment = users(:arch).comments.first

    patch comment_path(comment), params: { comment: { body: "I shouldn't be allowed to write this comment", post: comment.post}}
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
