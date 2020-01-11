require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    # This code is not idiomatically correct.
    @micropost = @user.posts.build(body: "Lorem ipsum", title: "ad")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "title should be present" do
    @micropost.title = "  "
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
