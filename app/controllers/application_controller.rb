class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper
  before_action :set_locale, :current_carts

  include Pagy::Backend

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def check_admin
    return if current_user.admin?

    flash[:danger] = t "admin.not_admin"
    redirect_to root_path
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "find_fail"
    redirect_to root_url
  end

  def check_login
    return if logged_in?

    flash[:danger] = t "please_login"
    redirect_to root_url
  end

  def check_user_activated
    return if @user.activated

    flash[:danger] = t "user_not_activated"
    redirect_to root_url
  end

  def correct_user
    return if current_user? @user

    redirect_to root_path
    flash[:danger] = t "user.not_correct_user"
  end
end
