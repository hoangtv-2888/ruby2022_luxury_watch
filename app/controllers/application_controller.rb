class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper
  include OrdersHelper
  before_action :set_locale, :current_carts
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend

  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::PROPERTIES
    devise_parameter_sanitizer.permit :account_update, keys: User::PROPERTIES
  end

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

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "find_fail"
    redirect_to root_url
  end

  def access_denied
    flash[:danger] = t "not_permission"
    redirect_to root_path
  end
end
