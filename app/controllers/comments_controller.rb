class CommentsController < ApplicationController
  before_action :correct_author, except: [:create]
  before_action :get_comment, except: [:create]

  def update
    respond_to do |format|
      if @comment.update(post_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @comment = Post.find_by_url(params[:post_id]).comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        #flash[:notice] = 'Your comment was successfully added!'
        #redirect_to @comment.post
        format.js 
      else
        flash[:error] = @comment.errors.full_messages.join("/n")
        redirect_to Post.find_by_url(params[:post_id])
      end
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to @comment.post
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def correct_author
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "You don't have the permissions to edit that comment."
      redirect_to @comment.post
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
