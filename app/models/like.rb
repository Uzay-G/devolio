class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  ## We make sure that one user can only have one like per post
  validates :user_id, uniqueness: {scope: :post_id}
end
