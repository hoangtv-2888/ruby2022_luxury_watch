class Admin::AdminController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  layout "admin"

  private
  def handle_err obj
    return if obj.present?

    flash[:warning] = t "not_found"
    redirect_to admin_root_path
  end

  def is_admin?
    return if current_user.admin?

    flash[:danger] = t "admin.not_admin"
    redirect_to root_path
  end
end
