class CreateOrderDetailJob < ApplicationJob
  queue_as :default

  def perform order, current_carts
    @order = order
    current_carts.each do |id, quantity|
      @product_detail = ProductDetail.find_by id: id
      @order.order_details.build(
        quantity: quantity,
        price_at_order: @product_detail.price,
        product_detail_id: @product_detail.id
      )
    end
    @order.save
  end
end
