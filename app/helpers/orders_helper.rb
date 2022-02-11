module OrdersHelper
  def multiple_price price, quantity
    price.to_f * quantity
  end

  def cal_discount discount, total
    discount = get_discount_percent discount
    total * discount / Settings.max_percent
  end

  def cal_purchase_price discount, total
    discount = get_discount_percent discount
    total - total * discount / Settings.max_percent
  end

  def total_price order
    order.order_details.sum("price_at_order * quantity")
  end

  def get_discount_percent discount
    return discount.percent if discount

    Settings.default_discount_percent
  end
end
