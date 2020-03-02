class ApplicationController < ActionController::Base
    before_action :require_login, except: [:home, :discuss, :feed]
    def home
        @user_zero = UserZero.new
    end

    def discuss
    end

    def require_no_user
        if current_user
            flash[:error] = "You must be logged out to access that page"
            redirect_back fallback_location: root_url
        end
    end

    def feed
       unless current_user
            @content = Post.all.sort_by { |post| post.score }.reverse
       else
            @content = Post.all.sort_by { |post| post.score + current_user.recommended?(post)}.reverse
       end
    end
    
    private
        def not_authenticated
            flash[:error] = "Please login first"
            redirect_to "/login"
        end
end
