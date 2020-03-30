class ApplicationController < ActionController::Base
    before_action :require_login, except: [:home, :discuss, :about, :search]
    def home
        @content = Kaminari.paginate_array(Post.all.sort_by { |post| post.score + (current_user&.recommended?(post)).to_f}.reverse).page(params[:page]).per(10)
    end

    def discuss
    end


    def require_no_user
        if current_user
            flash[:error] = "You must be logged out to access that page"
            redirect_back fallback_location: root_url
        end
    end

    def search
    end
    private
        def not_authenticated
            flash[:error] = "Please login first"
            redirect_to "/login"
        end
end
