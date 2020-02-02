class Project < ApplicationRecord
  require 'uri'
  include Likeable
  
  belongs_to :user

  validates :user_id, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true
end