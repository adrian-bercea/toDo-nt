class TaskMailer < ApplicationMailer
  def send_reminder(task_id)
    @task = Task.find(task_id)
    emails = @task.users.pluck(:email)
    Rails.logger.info "Sending reminders to #{emails.join(', ')}"
    Rails.logger.info "Task: #{@task.title}, Description: #{@task.description}"

    mail(to: emails, subject: "Task reminder: #{@task.title}")
  end
end
