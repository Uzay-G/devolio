class CommentsController < ApplicationController
  before_action :correct_author, except: [:create]

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      puts comment_params
      comment_post = @comment.root_post
      if @comment.update(comment_params)
        format.html { redirect_to post_path(comment_post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        flash[:error] = @comment.errors.full_messages.join("/n")
        redirect_to post_path(comment_post)
      end
    end
  end

  def create
    commentable = find_commentable
    @comment = commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        NotificationsMailer.reply_to(@comment.commentable.user, @comment).deliver
        format.js 
      else
        flash[:error] = @comment.errors.full_messages.join("/n")
        redirect_to @comment.root_post
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to post_path(@comment.root_post)
  end

  def correct_author
   @comment = Comment.first
   unless @comment.user == current_user
     flash[:error] = "You don't have the permissions to edit that comment."
     redirect_to post_path(@comment.root_post)
   end
  end

  def find_commentable(comment = nil)
    # constantize turns the string into an actual object
    if comment
      commentable_class = comment.commentable_type.constantize
      commentable_class.find(comment.commentable_id)
    else
      commentable_class = params[:commentable_type].constantize
      commentable_class.find(params[:commentable_id])
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
