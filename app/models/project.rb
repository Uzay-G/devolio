class Project < ApplicationRecord
  require 'uri'
  include Likeable
  include Followables

  belongs_to :user

  validates :user_id, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true
end