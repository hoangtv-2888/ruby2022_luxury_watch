namespace :user do
  desc "Send email admin"

  task send_email_admin: :environment do
    SendMailNotifyJob.set(wait: Settings.number_10.seconds).perform_later
  end
end
