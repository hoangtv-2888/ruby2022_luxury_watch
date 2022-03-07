class SendMailNotifyJob < ApplicationJob
  queue_as :default

  def perform
    orders = Order.by_status(Settings.wait)
    return unless orders

    users = User.admin
    users.each do |user|
      UserMailer.notity_admin(user).deliver_now
    end
  end
end
