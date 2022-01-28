class CartsController < ApplicationController
  def create
    add_cart params[:product_detail_id]
    flash[:success] = t "success"
    respond_to do |format|
      format.html{redirect_to request.referer}
      format.js
    end
  end

  def select_cart
    product_detail = load_product_detail cart_params

    respond_to do |format|
      format.json{render json: {cart_params: product_detail}}
    end
  end

  private

  def cart_params
    params.permit(:product_size_id,
                  :product_color_id,
                  :product_id)
  end

  def load_product_detail params
    ProductDetail.find_by params
  end

  def add_cart id
    current_carts[id] = if current_carts.key?(id)
                          current_carts[id] + Settings.quantity_defaut_1
                        else
                          Settings.quantity_defaut_1
                        end
  end
end
