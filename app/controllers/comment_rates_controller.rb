class CommentRatesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: :destroy

  def create
    @comment = current_user.comment_rates.build comment_params
    @comment.save ? flash[:success] = t("success") : flash[:danger] = t("error")
    redirect_back fallback_location: root_path
  end

  def destroy
    if @comment_rate.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_back fallback_location: root_path
  end

  private
  def comment_params
    params.require(:comment_rate).permit :content, :star, :product_id
  end
end
