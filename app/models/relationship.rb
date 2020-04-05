class Relationship < ApplicationRecord 

    belongs_to :followable, polymorphic: true
    belongs_to :follower, class_name: "User"

    validates :follower_id, presence: true
    validates :followable_id, presence: true
    validates_uniqueness_of :follower_id, :scope => :followable_id
end
