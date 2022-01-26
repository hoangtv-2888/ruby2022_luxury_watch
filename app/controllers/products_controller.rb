class ProductsController < ApplicationController
  before_action :load_product, only: :show
  def show; end

  private

  def load_product
    @product = Product.includes(:product_detail).find_by id: params[:id]

    if @product&.product_detail
      @product_color = []
      @product_size = []
      @product.product_detail.each do |product_detail|
        @product_color << product_detail.product_color
        @product_size << product_detail.product_size
      end
      return
    end
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end