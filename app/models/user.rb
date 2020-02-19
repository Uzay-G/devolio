class User < ApplicationRecord 
  include Likeable
  include Followable
  
  has_one_attached :avatar

  has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                          dependent:   :destroy

  # Fix this problem, for now only users can be followed
  has_many :following, through: :active_relationships, source: :followable, source_type: "User"


  has_many :projects, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery!
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 8 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }    
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

  include AlgoliaSearch
  algoliasearch do
    attributes :username, :github, :like_count

    searchableAttributes ['username', 'github']
    customRanking ['desc(like_count)']
  end
end