class UsersController < ApplicationController
  include UsersHelper
  
  skip_before_action :require_login, only: [:index, :new, :create, :show, :activate, :following, :followers]  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :require_no_user, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page params[:page]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
   # @user.custom_css = Sanitize::CSS.stylesheet(@user.custom_css, Sanitize::Config::RELAXED)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created. Please activate your account to log in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end


  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(:login, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(40)
    render 'relationships/show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(40)
    render 'relationships/show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :github, :avatar)
    end

    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:error] = "You don't have the permissions to edit that user."
        redirect_back fallback_location: root_url
      end
    end
end
