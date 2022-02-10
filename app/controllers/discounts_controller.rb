class DiscountsController < ApplicationController
  before_action :load_discounts, only: :show
  def show
    @discount = @discounts.first
    @total = params[:total].to_f

    respond_to do |format|
      format.html{redirect_to request.referer}
      format.js
    end
  end

  private
  def load_discounts
    @discounts = Discount.by_code(params[:code]).check_date
    return if @discounts.any?

    flash[:warning] = t "not_found_discount"
    if request.xhr?
      render(js: "window.location = '#{new_order_path}'") && return
    else
      redirect_to root_path
    end
  end
end
