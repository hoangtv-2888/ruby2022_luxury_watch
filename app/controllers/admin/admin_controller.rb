class Admin::AdminController < ApplicationController
  before_action :check_login, :check_admin

  layout "admin"

  private
  def handle_err obj
    return if obj.present?

    flash[:warning] = t "not_found"
    redirect_to admin_root_path
  end
end
