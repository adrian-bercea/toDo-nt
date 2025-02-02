class ChangeTaskIdAndCategoryIdInCategoriesTasks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :categories_tasks, :task_id, true
    change_column_null :categories_tasks, :category_id, true
  end
end
