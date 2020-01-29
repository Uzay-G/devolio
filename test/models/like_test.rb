require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  test "like a post" do
    post = posts(:one)
    post.like(users(:one))
    assert post.liked?(users(:one))
  end

  test "unlike a post" do
    post = posts(:one)
    post.like(users(:one))
    assert post.liked?(users(:one))

    post.unlike(users(:one))
    assert !post.liked?(users(:one))
  end
end
