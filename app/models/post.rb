class Post < ApplicationRecord

  acts_as_url :title

  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }

  def to_param
    url # or whatever you set :url_attribute to
  end

  def excerpt
    body.gsub!(/<img.*>/, "")
    if body.length > 150
      ActionController::Base.helpers.sanitize(body.truncate(150))
    else
      body.truncate(150) 
    end
  end
end
