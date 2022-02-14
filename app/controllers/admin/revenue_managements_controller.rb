class Admin::RevenueManagementsController < Admin::AdminController
  before_action :load_orders, :load_users
  def index; end

  private
  def load_orders
    @orders = OrderDetail.by_order_status([Settings.order_confirmed,
                                       Settings.order_shipping,
                                       Settings.order_delivered])
                         .group_by_day_of_week(:created_at, format: "%a")
                         .sum(:quantity)
    handle_err @orders
  end

  def load_users
    @users = User.group_by_day_of_week(:created_at, format: "%a").count
    handle_err @users
  end
end
