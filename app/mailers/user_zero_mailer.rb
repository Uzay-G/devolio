class UserZeroMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.uzer_zero_mailer.thanks.subject
  #
  def thanks(user)
    @user = user
    mail to: user.email, subject: "Welcome to Devolio!"
  end
end
