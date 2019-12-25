require 'test_helper'

class UserZerosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_zeros_create_url
    assert_response :success
  end

end
