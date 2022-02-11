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

  def show_cart
    @products = {}

    current_carts.each do |product_detail_id, quantity|
      product_detail = ProductDetail.find_by(id: product_detail_id)
      @products[product_detail] = quantity
    end
  end

  def total_money_cart
    total = 0
    current_carts.each do |id, quantity|
      product = check_product_cart id
      total_item = product.price * quantity
      total += total_item
    end
    total
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

  def total_money_order money, discount
    money - money * discount / Settings.number_100
  end

  def active_class_order type
    type == params[:type].to_i ? "active" : ""
  end
end
