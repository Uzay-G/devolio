require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "activation_needed_email" do
    user = User.first
    mail = UserMailer.activation_needed_email(user)
    assert_equal "Welcome to Devolio", mail.subject
    assert_equal user.email, mail.to[0]
    #assert_equal ["from@example.com"], mail.from
  end
end
