class ApplicationController < ActionController::Base
    before_action :require_login, except: [:home, :discuss]
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

    
    private
        def not_authenticated
            flash[:error] = "Please login first"
            redirect_to "/login"
        end
end
