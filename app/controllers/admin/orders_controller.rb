class Admin::OrdersController < Admin::AdminController
  before_action :load_order, except: :index

  def index
    @pagy, @orders = pagy Order.includes(:order_details, :user)
                               .search_id(params[:id]).newest
  end

  def show; end

  def update
    if @order.public_send("#{params[:order][:status]}!")
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
end
