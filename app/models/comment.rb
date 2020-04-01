class Comment < ApplicationRecord
  include Likeable

  belongs_to :user
  belongs_to :commentable
  include Commentabl

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
  validates_presence_of :body, :user, :commentable
end
