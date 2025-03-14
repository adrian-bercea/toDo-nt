class ApplicationMailer < ActionMailer::Base
  default from: "smtp@mailtrap.io"
  layout "mailer"
end
