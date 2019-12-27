class User < ApplicationRecord
  authenticates_with_sorcery!
    before_save { self.email = email.downcase }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :email, presence: true, length: { maximum: 255 },
                                      format: { with: VALID_EMAIL_REGEX }
 
    validates :password, length: { minimum: 3 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }    
    validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end