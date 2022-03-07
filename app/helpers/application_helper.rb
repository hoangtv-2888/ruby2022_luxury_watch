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

  def load_options model, value
    model.select(:id, value.to_sym).order(value.to_sym)
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = "<script>
                toastr.#{type}('#{message}',
                '', { closeButton: true, progressBar: true })
              </script>"
      flash_messages << text if message
    end.join("\n")
  end

  def load_price_option
    options = Array.new
    Settings.number_of_select.times do |n|
      options << [(n + 1) * Settings.cost_step, (n + 1) * Settings.cost_step]
    end
    options.unshift([t("all"), 0])
    options
  end
end
