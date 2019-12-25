class User < ApplicationRecord
  authenticates_with_sorcery!
    before_save { self.email = email.downcase }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   # validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: { case_sensitive: false }
 
    validates :password, length: { minimum: 3 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }    
    validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end