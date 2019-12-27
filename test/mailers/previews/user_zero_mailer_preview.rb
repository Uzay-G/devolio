# Preview all emails at http://localhost:3000/rails/mailers/uzer_zero_mailer
class UserZeroMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_zero_mailer/thanks
  def thanks
    @user_zero = UserZero.first
    UserZeroMailer.thanks(@user_zero)
  end

end
