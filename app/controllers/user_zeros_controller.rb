class UserZerosController < ApplicationController
  skip_before_action :require_login
  def new 
    @user = User.new
  end
  def create
    @user = UserZero.new(user_params)
    if @user.save
      flash[:notice] = "Hooray! We'll send you updates and we hope you'll like our platform."
    end
  end

  private
    def user_params
      params.require(:user_zero).permit(:email)
    end
end
