class HomesController < ApplicationController
  def index
    @pagy, @products = pagy Product.newest, items: Settings.items_per_page
  end

  def contact; end
end
