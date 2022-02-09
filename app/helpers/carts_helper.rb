module CartsHelper
  def current_carts
    session[:carts] ||= {}
  end

  def total_cart
    current_carts.blank? ? "" : current_carts.count
  end

  def total_quantity_cart
    current_carts.values.reduce(:+)
  end

  def price_item_cart quantity, price
    quantity * price
  end

  def total_money_cart
    total = 0
    current_carts.each do |id, quantity|
      product = check_product_cart id
      total_item = product.price * quantity
      total += total_item
    end
    number_to_currency(total)
  end

  def delete_item_cart product_detail_id
    return unless current_carts.key?(product_detail_id)

    current_carts.delete(product_detail_id)
  end

  def check_product_cart id
    product = ProductDetail.find_by(id: id)
    unless product
      flash[:danger] = t "not_found"
      delete_item_cart id
    end
    product
  end
end
