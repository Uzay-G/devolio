module Likeable
  extend ActiveSupport::Concern
  
  included do
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :likees, through: :likes, source: :user
  end

  # unlike the post
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def liked?(user)
    likees.include?(user)
  end

  def like(user)
    likes << Like.new(user_id: user.id)
  end
end