class TasksController < ApplicationController
  include ActionView::RecordIdentifier # For dom_id helper
  before_action :set_task, only: %i[show edit update destroy]

  def index
      @tasks = Task.all
      render
  end

  def show
  end

  def new
    @task = Task.new
  end

  # def new
  #   @task = Task.new
  #   @task.list_id = params[:list_id]
  #   @list_id = params[:list_id]
  # end

  def create
    @task = Task.new(task_params)
    @list_id = @task.list_id

    if @task.save
      # Set position to be at the beginning of the list

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("list_#{@task.list_id}_tasks", partial: "tasks/task", locals: { task: @task }),
            turbo_stream.replace("new-task-frame-#{@task.list_id}",
                                partial: "tasks/new_button",
                                locals: { list_id: @task.list_id })
          ]
        end
        format.html { redirect_to lists_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@task),
            partial: "tasks/task",
            locals: { task: @task }
          )
        end
        format.html { redirect_to tasks_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    list_id = @task.list_id # Store the list_id before destroying the task

    @task.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@task))
      end
      format.html { redirect_to lists_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :position, :list_id, category_ids: [])
  end
end
