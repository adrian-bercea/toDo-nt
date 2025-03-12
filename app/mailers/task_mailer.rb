class TaskMailer < ApplicationMailer
  def send_reminders(user_email)
    @user = User.find_by(email: user_email)
    @tasks = @user.tasks

    @tasks.each do |task|
      @task = task
      mail(to: @user.email, subject: 'Task Reminder')
    end
  end
end