module Followable
    extend ActiveSupport::Concern
    
    included do
        has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followable_id",
                                   dependent:   :destroy
        has_many :followers, through: :passive_relationships, source: :follower
    end
end