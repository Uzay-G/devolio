class Post < ApplicationRecord
  include Likeable
  
  acts_as_url :title

  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }

  def to_param
    url # or whatever you set :url_attribute to
  end

  def excerpt
    processed_excerpt = self.html_processed.gsub(/<img.*>/, "")
    ActionController::Base.helpers.sanitize(processed_excerpt.truncate(150))
  end

  def html_processed
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    ActionController::Base.helpers.sanitize(markdown.render(body))
  end
end
