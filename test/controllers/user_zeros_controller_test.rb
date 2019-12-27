require 'test_helper'

class UserZerosControllerTest < ActionDispatch::IntegrationTest
    test "posting to user_zeros should work" do
        assert_difference "UserZero.count" do
            post user_zeros_url, params: { user_zero: { email: "sdsd@ead.com" } }
        end
    end
end
