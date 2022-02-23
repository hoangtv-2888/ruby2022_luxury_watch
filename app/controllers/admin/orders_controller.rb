class Admin::OrdersController < Admin::AdminController
  load_and_authorize_resource

  def index
    @orders = Order.includes({order_details: [:product_detail]}, :user)
                   .search(params[:str]).newest
    if valid_status? params[:find_status]
      @orders = @orders.public_send(params[:find_status].to_s)
    end
    confirm_all_new @orders, params[:status_change] if params[:status_change]
    @pagy, @orders = pagy @orders
  end

  def show; end

  def update
    if valid_status? params[:order][:status]
      @order.public_send("#{params[:order][:status]}!")
      send_mail @order
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_orders_path
  end

  private

  def order_params
    params.require(:order).permit :status
  end

  def confirm_all_new order_list, status
    return unless status == Settings.order_status.confirmed

    if order_list.public_send(Settings.order_status.wait).any?
      order_list.public_send(Settings.order_status.wait).each do |order|
        order.public_send("#{status}!")
        send_mail order
      end
      flash[:success] = t "success"
    else
      flash[:warning] = t "not_found"
    end
    redirect_to admin_orders_path
  end

  def valid_status? status
    Order.statuses.include? status
  end

  def send_mail order
    UserMailer.order_status(order).deliver_now
  end
end
