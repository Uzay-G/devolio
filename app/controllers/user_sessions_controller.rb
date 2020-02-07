class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :require_no_user, only: [:new, :create]

  def new
    @user = User.new
    session[:party] = params[:return_to]
  end

  def create
    if @user = login(params[:username], params[:password], params[:remember])
      flash[:notice] = 'Login successful'
      redirect_to session[:party] || @user
    else
      flash[:error] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'Logged out!'
    redirect_to params[:return_to] || :users
  end
end
