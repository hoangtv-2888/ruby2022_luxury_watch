class SendAllMailJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 5

  def perform order
    UserMailer.order_status(order).deliver_now
  end
end
