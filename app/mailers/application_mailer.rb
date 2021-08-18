class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.gmail[:from_email]
  layout 'mailer'
end
