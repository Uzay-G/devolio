class ApplicationController < ActionController::Base
    before_action :require_login, except: [:home, :discuss]
    def home
        @user_zero = UserZero.new
    end

    def discuss
    end
    private
        def not_authenticated
            redirect_to "/login", error: "Please login first"
        end
end
