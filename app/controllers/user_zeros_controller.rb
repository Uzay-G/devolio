class UserZerosController < ApplicationController
  skip_before_action :require_login
  def new 
    @user_zero = UserZero.new
  end
  def create
    @user_zero = UserZero.new(user_params)
    respond_to do |format|
      if @user_zero.save
        flash[:success] = "You were successfully subscribed! We'll send you updates and we hope you'll like our platform."
        UserZeroMailer.thanks(@user_zero).deliver_now
        format.html do
          redirect_to "/discuss"
        end
      else
        format.html { render "application/home" }
        format.json { render json: @user_zero.errors, status: :unprocessable_entity }
      end
   # if @user.save
      #flash[:notice] = "Hooray! We'll send you updates and we hope you'll like our platform."
   # else
   #   render :new
    end
  end

  private
    def user_params
      params.require(:user_zero).permit(:email)
    end
end
