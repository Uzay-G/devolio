require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    test_login_as(users(:one), "secret")
  end

  test "should get create" do
    assert_difference("Comment.count", 1) do
      post comments_url, params: {  commentable_id: Post.first.id, commentable_type: "Post", comment: { body: "This is a comment!" } }, xhr: true
    end
    assert_response :success
  end

  test "different user cannot update or delete someone else's comment" do
    comment = users(:arch).comments.first

    patch "/comments/#{comment.id}", params: { comment: { body: "I shouldn't be allowed to write this comment"} }
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to Post.find(comment.commentable_id)

    delete "/comments/#{comment.id}"
    assert_equal flash[:error], "You don't have the permissions to edit that comment."
    assert_redirected_to Post.find(comment.commentable_id)
  end

  # test "should update comment" do
  #   comment = users(:one).comments.first
  #   patch "/comments/#{comment.id}", params: { commentable_type: "Post", commentable_id: comment.commentable_id, comment: { body: "I am updating this comment!" } }

  #   assert_equal "I am updating this comment!", Comment.find(comment.id).body
  # end
    # test "deleting a comment" do
    #   comment = comments(:one)
    #  # assert_difference("Comment.count", -1) do
    #    # delete "/comments/#{comment.id}"
    # #  end
    #   assert_redirected_to comment.post
    #   assert_equal flash[:notice], "Comment deleted!"
    # end
end
