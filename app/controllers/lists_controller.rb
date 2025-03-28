class ListsController < ApplicationController
  before_action :set_list, except: [ :index, :new, :create, :update_position ]

  def index
    @lists = List.order(:position)
  end

  def show
    @tasks = @list.tasks.order(:position)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    # @list.position = (List.maximum(:position) || 0) + 1

    if @list.save
      redirect_to lists_path, notice: "List created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: "List updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "List deleted successfully"
  end

  def update_position
    position = params[:position].to_i
    @list.insert_at(position)
    head :ok
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :position)
  end
end
