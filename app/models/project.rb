class Project < ApplicationRecord
  require 'uri'
  include Likeable
  include Followable

  belongs_to :user

  validates :description, length: { maximum: 70 }
  validates :user_id, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true
end