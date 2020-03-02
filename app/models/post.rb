class Post < ApplicationRecord
  include Likeable
  include Commentabl
  
  acts_as_url :title

  has_many_attached :images
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }

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

  def html_processed
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    ActionController::Base.helpers.sanitize(markdown.render(body))
  end

  



  include AlgoliaSearch
  algoliasearch index_name: "dev", id: :algolia_id do
    attributes :title, :body, :like_count

    searchableAttributes ['title', 'unordered(body)']
    customRanking ['desc(like_count)']
  end

  private
    def algolia_id
      "post_#{id}"
    end
end
