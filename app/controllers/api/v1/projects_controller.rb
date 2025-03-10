module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: %i[show update destroy stats]

      # GET /api/v1/projects
      def index
        result = Projects::FetchService.call(current_user)

        render json: result.data, include: { tasks: { only: %i[id name status] } }
      end

      # GET /api/v1/projects/1
      def show
        render json: @project, include: :tasks
      end

      # POST /api/v1/projects
      def create
        result = Projects::CreateService.call(current_user, project_params)

        if result.success?
          render json: result.data, status: :created
        else
          render json: { errors: result.error }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/projects/1
      def update
        result = Projects::UpdateService.call(@project, project_params)

        if result.success?
          render json: result.data
        else
          render json: { errors: result.error }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/projects/1
      def destroy
        Projects::DestroyService.call(@project)

        head :no_content
      end

      # GET /api/v1/projects/1/stats
      def stats
        result = Projects::StatsService.call(@project)

        render json: { stats: result.data }
      end

      private

      def set_project
        @project = current_user.projects.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Project not found" }, status: :not_found
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
