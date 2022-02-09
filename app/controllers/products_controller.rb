class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def show
    @pagy, @comments = pagy @product.comment_rates.newest,
                            items: Settings.comments_per_page
    @comment_rate = CommentRate.new
  end

  private
  def load_product
    @product = Product.includes(:product_detail).find_by id: params[:id]
    unless @product
      flash[:danger] = t "not_found"
      return redirect_to root_path
    end
    @product_color = Array.new
    @product_size = Array.new
    @product.product_detail.each do |product_detail|
      @product_color << product_detail.product_color
      @product_size << product_detail.product_size
    end
    @product_color = @product_color.uniq
    @product_size = @product_size.uniq
  end
end
