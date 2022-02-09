class CartsController < ApplicationController
  def index
    @products = {}

    current_carts.each do |product_detail_id, quantity|
      product_detail = ProductDetail.find_by(id: product_detail_id)
      @products[product_detail] = quantity
    end
  end

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

  def update
    update_quantity_cart params[:product_detail_id], params[:quantity]
    @quantity = params[:quantity].to_i
    @product_detail = ProductDetail.find_by id: params[:product_detail_id]

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @product_detail_id = params[:id]
    delete_item_cart params[:id]

    respond_to do |format|
      format.html{redirect_to request.referer}
      format.js
    end
  end

  private

  def cart_params
    params.permit(:product_size_id,
                  :product_color_id,
                  :product_id)
  end

  def update_quantity_cart product_detail_id, quantity
    current_carts[product_detail_id] = if current_carts.key?(product_detail_id)
                                         quantity.to_i
                                       else
                                         Settings.quantity_defaut_1
                                       end
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
