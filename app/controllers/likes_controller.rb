class LikesController < ApplicationController
  before_action :find_likeable

  def create
    @likeable.like(current_user)
    redirect_to @likeable
  end

  def destroy
    @likeable.unlike(current_user)
    redirect_to @likeable
  end
  
  private  

  def find_likeable
    # constantize turns the string into an actual object
    likeable_class = params[:likeable_type].constantize
    @likeable = likeable_class.find(params[:likeable_id])
  end
end
