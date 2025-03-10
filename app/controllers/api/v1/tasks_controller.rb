module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_project
      before_action :set_task, only: %i[show update destroy]

      # GET /api/v1/projects/1/tasks
      def index
        result = Tasks::FetchService.call(@project, params[:status])

        render json: result.data
      end

      # GET /api/v1/projects/1/tasks/1
      def show
        render json: @task
      end

      # POST /api/v1/projects/1/tasks
      def create
        result = Tasks::CreateService.call(@project, task_params)

        if result.success?
          render json: result.data, status: :created
        else
          render_errors(result.error)
        end
      end

      # PATCH/PUT /api/v1/projects/1/tasks/1
      def update
        result = Tasks::UpdateService.call(@task, task_params)

        if result.success?
          render json: result.data
        else
          render_errors(result.error)
        end
      end

      # DELETE /api/v1/projects/1/tasks/1
      def destroy
        Tasks::DestroyService.call(@task)

        head :no_content
      end

      private

      def render_errors(errors)
        render json: { errors: errors }, status: :unprocessable_entity
      end

      def set_project
        @project = @current_user.projects.find(params[:project_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Project not found" }, status: :not_found
      end

      def set_task
        @task = @project.tasks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Task not found" }, status: :not_found
      end

      def task_params
        params.require(:task).permit(:name, :description, :status)
      end
    end
  end
end
