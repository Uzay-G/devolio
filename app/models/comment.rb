class Comment < ApplicationRecord
  include Likeable
  include Commentable

  belongs_to :user
  belongs_to :commentable

  validates_presence_of :body, :user, :commentable
  
  def root_post
    parent = self
    until parent.class.name == "Post"
      parent = parent.commentable
    end
    parent  
  end
  
  def commentable
    commentable_type.constantize.find(commentable_id)
  end
end
