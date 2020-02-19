require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  
  def setup
    @relationship = Relationship.new(follower: users(:lana),
                                     followable: users(:arch))
  end

  test "should be valid" do
     assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followable_id" do
    @relationship.followable_id = nil
    assert_not @relationship.valid?
  end
end
