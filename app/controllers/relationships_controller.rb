class RelationshipsController < ApplicationController

    def create
        followable_class = params[:followable_type].constantize
        @followable = followable_class.find(params[:followable_id])
        current_user.follow(@followable)
        respond_to do |format|
            format.html { redirect_to @followable }
            format.js
          end      
      end

    def destroy
        @followable = Relationship.find(params[:id]).followable
        current_user.unfollow(@followable)
        respond_to do |format|
            format.html { redirect_to @followable }
            format.js
        end
    end
end
