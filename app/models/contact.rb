class Contact < MailForm::Base

    attribute :name,      :validate => true, presence: true
    attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, presence: true
    attribute :message, presence: true
    attribute :nickname,  :captcha  => true
  
    def headers
      {
        :subject => "Contact Form",
        :to => "uzgirit@gmail.com",
        :from => %("#{name}" <#{email}>)
      }
    end
  
end
