class OrdersController < ApplicationController
  before_action :check_login, :show_cart
  before_action :init_order, only: %i(create)
  before_action :show_cart, only: %i(new)

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
    @order = Order.new order_params
    @order.status = Settings.status_order_new
    @order.user_id = current_user.id
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
end
