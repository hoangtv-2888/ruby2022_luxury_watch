class HomesController < ApplicationController
  def index
    @q = Product.includes(:category, :product_detail).ransack(params[:q])
    @products = @q.result(distinct: true)
    @pagy, @products = pagy @products, items: Settings.items_per_page
    @hot_sell = Product.hot_sell(Settings.size_hot_sell)
    load_filter_options
  end

  def contact; end

  private

  def load_filter_options
    @categories = Category.pluck(:name, :id).unshift([t("all"), nil])
    @colours = ProductColor.pluck(:color, :id).unshift([t("all"), nil])
    @sizes = ProductSize.pluck(:size, :id).unshift([t("all"), nil])
  end
end
