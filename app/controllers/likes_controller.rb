class LikesController < ApplicationController
  before_action :find_likeable

  def create
    @post.like(current_user)
    redirect_to post_path(@post)
  end

  def destroy
    @post.unlike(current_user)
    redirect_to post_path(@post)
  end
  
  private  

  def find_likeable
    @post = Post.find(params[:likeable_id])
  end
end
