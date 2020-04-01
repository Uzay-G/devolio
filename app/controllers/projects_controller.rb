class ProjectsController < ApplicationController
    before_action :require_login, except: [:show, :index]
    before_action :correct_author, only: [:update, :edit, :destroy]
    before_action :get_post, except: [:create, :new, :index]

    def index
      @projects = Kaminari.paginate_array(Project.all.sort_by { |project| project.created_at }).page(params[:page]).per(6)
    end

    def create
        @project = current_user.projects.build(project_params)
        respond_to do |format|
          if @project.save
            format.html { redirect_to @project, notice: 'Project was successfully created.' }
            format.json { render :show, status: :ok, location: @project }
          else
            format.html { render :edit }
            format.json { render json: @project.errors, status: :unprocessable_entity }
          end
        end
    end

    def update
        respond_to do |format|
          if @project.update(project_params)
            format.html { redirect_to @project, notice: 'Project was successfully updated.' }
            format.json { render :show, status: :ok, location: @project }
          else
            format.html { render :edit }
            format.json { render json: @project.errors, status: :unprocessable_entity }
          end
        end
      end

    def edit
    end

    def destroy
        @project.destroy
        flash[:notice] = "Project deleted"
        redirect_back fallback_location: @project.user
    end

    def show
      @post = Post.new
    end

    def new
        @project = Project.new
    end

    def correct_author
      @project = Project.find(params[:id])
      unless @project.user == current_user
        flash[:error] = "You don't have the permissions to edit that project."
        redirect_to @project
      end
    end

    def get_post
      @project = Project.find(params[:id])
    end

    private 
        def project_params
            params.require(:project).permit(:name, :url, :source, :description, :logo)
        end
end
