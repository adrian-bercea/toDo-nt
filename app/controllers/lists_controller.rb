class ListsController < ApplicationController
  before_action :set_list, except: [ :index, :new, :create ]

  def index
    @lists = List.rank(:row_order)
  end

  def show
    @tasks = @list.tasks
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

  def sort
    @list.update(row_order_position: params[:row_order_position])
    head :ok
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :row_order_position)
  end
end
