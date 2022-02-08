class CommentRatesController < ApplicationController
  before_action :load_product, only: :create
  before_action :load_comment_rate, :correct_user?, only: :destroy

  def create
    @comment = current_user.comment_rates.build comment_params
    @comment.save ? flash[:success] = t("success") : flash[:danger] = t("error")
    redirect_back fallback_location: root_path
  end

  def destroy
    if @comment_rate.destroy
      flash[:success] = t("success")
    else
      flash[:danger] = t("error")
    end
    redirect_back fallback_location: root_path
  end

  private
  def comment_params
    params.require(:comment_rate).permit :content, :star, :product_id
  end

  def load_product
    @product = Product.find_by id: params.dig(:comment_rate, :product_id)
    return if @product

    flash[:danger] = t "not_found"
    redirect_back fallback_location: root_path
  end

  def load_comment_rate
    @comment_rate = CommentRate.find_by id: params[:id]
    return if @comment_rate

    flash[:danger] = t "not_found"
    redirect_back fallback_location: root_path
  end

  def correct_user?
    return if @comment_rate.user == current_user

    flash[:danger] = t "error"
    redirect_to root_path
  end
end
