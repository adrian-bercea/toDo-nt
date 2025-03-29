class TasksController < ApplicationController
  include ActionView::RecordIdentifier # For dom_id helper
  before_action :set_task, except: %i[index new create]

  def index
      @tasks = Task.all
      render
  end

  def new
    @task = Task.new(list_id: params[:list_id])
  end

  def create
    @task = Task.new(task_params)
    @task.row_order_position = 0 # Position at the top

    if @task.save
      respond_to do |format|
        format.turbo_stream # This will use create.turbo_stream.erb
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

  def sort
    @task.update(row_order_position: params[:row_order_position], list_id: params[:list_id])
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :row_order_position, :list_id, category_ids: [])
  end
end
