class PostsController < ApplicationController
    @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    def create
        @post = current_user.posts.build(post_params)
        @post.body = @@markdown.render(@post.body)
        if @post.save
          flash[:notice] = "Post created!"
          redirect_to @post
        else
          flash[:error] = "Post could not be created"
          redirect_to root_url
        end
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
