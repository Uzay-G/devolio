require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get root_path
    assert_response :success
  end

  test "should get discuss" do
    get "/discuss"
    assert_response :success
  end

  test "should get about" do
    get "/about"
    assert_response :success
  end

  test "should get search" do
    get "/search"
    assert_response :success
  end
end
