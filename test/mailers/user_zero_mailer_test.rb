require 'test_helper'

class UserZeroMailerTest < ActionMailer::TestCase
  test "thanks" do
    user = User.first
    mail = UserZeroMailer.thanks(user)
    assert_equal "Welcome to Devolio!", mail.subject
   # assert_equal ["to@example.org"], mail.to
   # assert_equal ["from@example.com"], mail.from
   # assert_match "Hi", mail.body.encoded
  end

end
