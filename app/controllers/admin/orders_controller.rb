class Admin::OrdersController < Admin::AdminController
  before_action :load_order, except: :index

  def index
    @orders = Order.includes(:order_details, :user)
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
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_orders_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "not_found"
    redirect_to admin_order_path
  end

  def order_params
    params.require(:order).permit :status
  end

  def confirm_all_new order_list, status
    return unless status == Settings.order_status.confirmed

    if order_list.public_send(Settings.order_status.wait).any?
      order_list.public_send(Settings.order_status.wait).each do |order|
        order.public_send("#{status}!")
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
end
