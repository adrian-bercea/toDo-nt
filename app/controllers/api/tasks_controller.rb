module Api
  class TasksController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? } # CSRF protection is disabled for JSON requests, no bueno but just for giggles

    def index
      @tasks = Task.includes(:categories).all
      render json: tasks_collection_json
    end

    def show
      @task = Task.includes(:categories).find(params[:id])
      render json: task_json(@task)
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        render json: task_json(@task)
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def tasks_collection_json
      {
        collection: {
          version: "1.0",
          href: api_tasks_url,
          items: @tasks.map { |task| task_data(task) }
        }
      }
    end

    def task_json(task)
      {
        task: task_data(task)
      }
    end

    def task_data(task)
      {
        href: api_task_url(task),
        data: [
          { name: "id", value: task.id },
          { name: "title", value: task.title },
          { name: "description", value: task.description },
          { name: "completed", value: task.completed },
          { name: "created_at", value: task.created_at },
          { name: "updated_at", value: task.updated_at },
          { name: "categories", value: task.categories&.map(&:name) }
        ]
      }
    end

    def task_params
      params.require(:task).permit(:title, :description, :completed, category_ids: [])
    end
  end
end
