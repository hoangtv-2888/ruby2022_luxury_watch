class HomesController < ApplicationController
  def index
    @products = Product.search_by_name(params[:name]).newest
    filtering_params(params).each do |key, value|
      unless value == "0"
        @products = @products.public_send("filter_by_#{key}", value)
      end
    end
    @pagy, @products = pagy @products, items: Settings.items_per_page
    @hot_sell = Product.hot_sell(Settings.size_hot_sell)
    load_filter_options
  end

  def contact; end

  private

  def load_filter_options
    @categories = Category.pluck(:name, :id).unshift([t("all"), 0])
    @colours = ProductColor.pluck(:color, :id).unshift([t("all"), 0])
    @sizes = ProductSize.pluck(:size, :id).unshift([t("all"), 0])
  end

  def filtering_params params
    params.slice(:cost, :category_id, :product_color_id,
                 :product_size_id, :min_price, :max_price)
  end
end
