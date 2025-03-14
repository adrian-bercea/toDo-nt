class TaskMailer < ApplicationMailer
  def send_reminder(task_id)
    @task = Task.find(task_id)
    Rails.logger.info "Sending reminders to #{@task.user.email}"
    Rails.logger.info "Task: #{@task.title}, Description: #{@task.description}"

    mail(to: @task.user.email, subject: "Task reminder: #{@task.title}")
  end
end
