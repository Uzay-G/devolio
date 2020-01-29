class PostsController < ApplicationController
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
          flash[:notice] = "Post created!"
          redirect_to @post
        else
          flash[:error] = "Post could not be created"
          redirect_to root_url
        end
    end

    def update
        @post = Post.find_by_url(params[:id])
        respond_to do |format|
          if @post.update(post_params)
            format.html { redirect_to @post, notice: 'Post was successfully updated.' }
            format.json { render :show, status: :ok, location: @post }
          else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end
    def edit
      @post = Post.find_by_url(params[:id])
    end

    def destroy
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_back fallback_location: root_url
    end

    def show
        @post = Post.find_by_url(params[:id])
    end 
    def new
        @post = Post.new
    end
    private
        def post_params
            params.require(:post).permit(:title, :body)
        end
end
