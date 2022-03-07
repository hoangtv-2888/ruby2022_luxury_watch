# config/schedule.rb
require_relative "environment"
env :PATH, ENV['PATH']
set :environment, Rails.env
set :output, "log/cron_job.log"

every Settings.number_1.day, at: Settings.hour_notify_day do
  rake "user:send_email_admin"
end
