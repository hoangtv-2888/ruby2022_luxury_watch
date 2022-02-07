module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "app.title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def log_in user
    session[:user_id] = user.id
  end

  def load_avg_star product
    return Settings.default_star if product.comment_rates.to_a.blank?

    product.comment_rates.average(:star).round
  end
end
