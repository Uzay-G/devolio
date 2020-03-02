class Project < ApplicationRecord
  require 'uri'
  include Followable

  has_one_attached :logo
  
  belongs_to :user

  validates :description, length: { maximum: 70 }
  validates :user_id, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true

  include AlgoliaSearch
  algoliasearch index_name: "dev", id: :algolia_id do
    attributes :title, :body, :like_count

    searchableAttributes ['name', 'unordered(body)']
    customRanking ['desc(like_count)']
  end
  
  ## Define custom methods so that records can be indexed on same indice with algolia
  def like_count
    follower_count
  end

  def title
    name
  end

  def body
    description
  end

  private
    def algolia_id
      "project_#{id}"
    end
end