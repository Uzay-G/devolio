class CommentsController < ApplicationController
  before_action :correct_author, except: [:create]
  before_action :find_commentable
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
    @comment = @commentable.comments.build(comment_params)
    
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        #flash[:notice] = 'Your comment was successfully added!'
        #redirect_to @comment.post
        format.js 
      else
        flash[:error] = @comment.errors.full_messages.join("/n")
        redirect_to @commentable
      end
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to @comment.post
  end

  def correct_author
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "You don't have the permissions to edit that comment."
      redirect_to @comment.post
    end
  end

  def find_commentable
    # constantize turns the string into an actual object
    commentable_class = params[:commentable_type].constantize
    @commentable = commentable_class.find(params[:commentable_id])
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
