module CartsHelper
  def current_carts
    session[:carts] ||= {}
  end

  def total_cart
    session[:carts].values.reduce(:+)
  end
end
