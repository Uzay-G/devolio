require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @project = projects(:one)
  end

  test "like a post" do
    @post.like(users(:one))
    assert @post.liked?(users(:one))
  end

  test "unlike a post" do
    @post.like(users(:one))
    assert @post.liked?(users(:one))

    @post.unlike(users(:one))
    assert !@post.liked?(users(:one))
  end

  test "should not be able to like post multiple times" do
    like = Like.new(user: users(:malory), likeable: @post)
    like.valid?
    like.save

    like = Like.new(user: users(:malory), likeable: @post)
    assert_not like.valid?
  end 

  test "should not be able to like project multiple times" do
    like = Like.new(user: users(:one), likeable: @project)
    assert like.valid?
    like.save

    like = Like.new(user: users(:one), likeable: @project)
    assert_not like.valid?
  end 
end
