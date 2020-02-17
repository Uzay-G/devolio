class Project < ApplicationRecord
  require 'uri'
  include Followable

  has_one_attached :logo
  
  belongs_to :user

  validates :description, length: { maximum: 70 }
  validates :user_id, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true

  include AlgoliaSearch
  algoliasearch do
    attributes :name, :description, :url, :source, :follower_count

    searchableAttributes ['name', 'url', 'source', 'unordered(description)']
    customRanking ['desc(follower_count)']
  end
end