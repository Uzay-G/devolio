require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup
    @project = users(:one).projects.build(name: "Devolio", description: "ssdadda")
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "user id should be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end

  test "incorrect urls" do
    incorrect_urls = %w[httpa.com devol,io www. hiatus /wyatt]
    incorrect_urls.each do |url|
      @project.url = url
      assert_not @project.valid?
    end
  end

  test "correct urls" do
    correct_urls = ["https://www.devol.io", "http://uzpg.me", "https://drive.google.com", "", nil]
    correct_urls.each do |url|
      @project.url = url
      assert @project.valid?
    end
  end
end
