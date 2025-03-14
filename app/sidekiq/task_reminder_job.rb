class TaskReminderJob
  include Sidekiq::Job

  sidekiq_options queue: "mailers"

  def perform(task_id)
    task = Task.find(task_id)

    # Ensure idempotency
    return if task.reminder_sent? || task.user.nil?

    # Send reminder
    TaskMailer.send_reminder(task_id).deliver_now

    # Mark the task as reminder sent
    task.update(reminder_sent: true)
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Task not found: #{e.message}"
  rescue StandardError => e
    logger.error "Failed to send reminder: #{e.message}"
    raise e
  end
end
