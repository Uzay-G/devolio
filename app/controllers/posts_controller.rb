class PostsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :correct_author, only: [:update, :edit, :destroy]
  before_action :get_post, except: [:create, :new]

    def create
        @post = current_user.posts.build(post_params)
        respond_to do |format|
          if @post.save
            format.html { redirect_to @post, notice: 'Post was successfully created.' }
            format.json { render :show, status: :ok, location: @post }
          else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
    end

    def update
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
    end

    def destroy
        @post.destroy
        flash[:notice] = "Post deleted!"
        redirect_to @post.user
    end

    def show
    end

    def new
        @post = Post.new
    end

    def correct_author
      @post = Post.find_by_url(params[:id])
      unless @post.user == current_user
        flash[:error] = "You don't have the permissions to edit that post."
        redirect_to @post
      end
    end

    def get_post
      @post = Post.find_by_url(params[:id])
    end

    private
        def post_params
            params.require(:post).permit(:title, :body, :images => [])
        end
end
