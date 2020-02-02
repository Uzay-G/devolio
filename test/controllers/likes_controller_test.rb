require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:malory)
    test_login_as(@user, "sedscret")
  end

  test "creating a like for a post" do
    assert_difference("Like.count", 1) do
      post likes_path, params: { likeable_id: Post.first.id }
    end
  end

  # test "deleting a like for a post" do
  #   post = posts(:one)
  #   assert_difference("Like.count", -1) do
  #     delete "/likes/#{likes(:one).id}", params: { post_id: post.id }
  #   end
  # end
end
