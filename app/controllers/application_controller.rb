class ApplicationController < ActionController::Base
    before_action :require_login, except: [:home]
    def home
    end

    private
        def not_authenticated
            redirect_to "/login", alert: "Please login first"
        end
end
