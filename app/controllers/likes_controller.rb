class LikesController < ApplicationController
  before_action :find_likeable

  def create
    @likeable.like(current_user)
    respond_to do |format|
      format.html { redirect_to @likeable }
      format.js
    end
  end

  def destroy
    @likeable.unlike(current_user)
    respond_to do |format|
      format.html { redirect_to @likeable }
      format.js
    end
  end
  
  private  

  def find_likeable
    # constantize turns the string into an actual object
    likeable_class = params[:likeable_type].constantize
    @likeable = likeable_class.find(params[:likeable_id])
  end
end
