class AddReminderSentToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :reminder_sent, :boolean, default: false
  end
end
