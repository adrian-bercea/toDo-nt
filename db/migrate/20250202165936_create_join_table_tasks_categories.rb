class CreateJoinTableTasksCategories < ActiveRecord::Migration[8.0]
  def change
    create_join_table :tasks, :categories do |t|
      t.index :task_id
      t.index :category_id
    end
  end
end
