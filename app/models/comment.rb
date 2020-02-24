class Comment < ApplicationRecord
  include Likeable

  belongs_to :user
  belongs_to :commentable

  include Commentable
  validates_presence_of :body, :user, :commentable
end
