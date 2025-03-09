class TaskReminderJob
  include Sidekiq::Job

  def perform(task_id)
    task = Task.find(task_id)
    # Ensure idempotency
    return if task.reminder_sent?

    # Send reminder (implement your reminder logic here)
    TaskMailer.reminder(task).deliver_now

    # Mark the task as reminder sent
    task.update(reminder_sent: true)
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Task not found: #{e.message}"
  rescue StandardError => e
    logger.error "Failed to send reminder: #{e.message}"
    raise e
  end
end
