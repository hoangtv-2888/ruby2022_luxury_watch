class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :init_order, only: %i(create)
  before_action :show_cart, only: %i(new)
  before_action :show_history_orders, only: %i(index)
  before_action :load_order, only: %i(show update)
  before_action :update_status, only: %i(update)

  def index; end

  def new; end

  def create
    create_order_detail
    ActiveRecord::Base.transaction do
      @order.save!
    end
    handle_success_order
  rescue NoMethodError
    handle_exception e
  end

  def show; end

  def update
    respond_to do |format|
      format.html{redirect_to request.referer}
      format.js
    end
  end

  private
  def order_params
    params.permit :user_name_at_order,
                  :address_at_order,
                  :discount_id
  end

  def create_order_detail
    current_carts.each do |id, quantity|
      @product_detail = ProductDetail.find_by id: id
      @order.order_details.build(
        quantity: quantity,
        price_at_order: @product_detail.price,
        product_detail_id: @product_detail.id
      )
    end
  end

  def init_order
    @order = current_user.orders.new order_params
    @order.status = Settings.order_wait
  end

  def handle_success_order
    current_carts.clear
    flash[:success] = t "success"
    redirect_to root_url
  end

  def handle_exception exception
    log exception
    flash.now[:danger] = t "error"
    redirect_to root_url
  end

  def show_history_orders
    @pagy, @orders = pagy current_user.orders.includes(:order_details)
                                      .by_status(params[:type])
                                      .newest
  end

  def load_order
    @order = current_user.orders.find_by id: params[:id]
    return if @order

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def update_status
    begin
      if @order.status_buy_again?
        return if @order.wait!
      elsif @order.wait?
        return if @order.rejected!
      end
    end
  rescue StandardError => e
    handle_exception e
  end
end
