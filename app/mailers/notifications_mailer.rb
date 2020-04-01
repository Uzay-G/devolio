class NotificationsMailer < ApplicationMailer

    def reply_to(user, comment)
        @user = user
        @comment = comment
        mail to: user.email, subject: "#{comment.user.username} replied to you on Devolio"
    end
end
