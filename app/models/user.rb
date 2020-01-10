class User < ApplicationRecord
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  authenticates_with_sorcery!
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 3 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }    
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def follow(user)
    following << user
  end
  def unfollow(user)
    following.delete(user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end