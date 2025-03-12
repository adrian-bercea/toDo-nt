class TaskMailer < ApplicationMailer
  def send_reminders(user_email)
    @user = User.find_by(email: user_email)
    @tasks = @user.tasks
     Rails.logger.info "Sending reminders to #{@user.email}"
    @tasks.each do |task|
      Rails.logger.info "Task: #{task.title}, Description: #{task.description}"
    end

    mail(to: @user.email, subject: "Task Reminder")
  end
end
