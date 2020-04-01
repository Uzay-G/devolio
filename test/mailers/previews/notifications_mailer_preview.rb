# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview
    def reply_to
        user = User.find(2)
        comment = user.comments.first
        NotificationsMailer.reply_to(user, comment)
    end
end
