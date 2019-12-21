require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get root_path
    assert_response :success
  end
end
