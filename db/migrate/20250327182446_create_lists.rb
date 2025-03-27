class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :position
      t.timestamps
    end

    # Add list_id to tasks
    add_reference :tasks, :list, foreign_key: true
  end
end
