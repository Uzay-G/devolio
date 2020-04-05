class Post < ApplicationRecord
  include Likeable
  include Commentable
  
  acts_as_url :title

  has_many_attached :images
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }

  belongs_to :project, optional: true

  include SimpleRecommender::Recommendable
  similar_by :likees
  
  def to_param
    url # or whatever you set :url_attribute to
  end

  def excerpt
    processed_excerpt = self.html_processed.gsub(/<img.*>/, "")
    ActionController::Base.helpers.sanitize(processed_excerpt.truncate(350))
  end

  def score
    (likes.size + comments.size / 1.3) / ((Time.now.to_i - created_at.to_i) ** 1.4)
  end

  def domain
    if content_type == "link"
      URI.parse(body).host
    else
      nil
    end
  end
  
  def html_processed
    if content_type == "image"
      ActionController::Base.helpers.sanitize("<img src='#{body}'>")
    else
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
      ActionController::Base.helpers.sanitize(markdown.render(body))
    end
  end

  def relative_url 
    "/posts/#{url}"
  end



  include AlgoliaSearch
  algoliasearch index_name: Rails.application.config.algolia_index, id: :algolia_id do
    attributes :title, :body, :like_count, :relative_url

    searchableAttributes ['title', 'unordered(body)']
    customRanking ['desc(like_count)']
  end

  private
    def algolia_id
      "post_#{id}"
    end
end
