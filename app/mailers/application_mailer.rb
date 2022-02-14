class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAIL_HOST"]
  layout "mailer"
  helper :orders
end
