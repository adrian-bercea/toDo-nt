class RemovePositionFromListsAndTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :lists, :position, :integer
    remove_column :tasks, :position, :integer
  end
end
