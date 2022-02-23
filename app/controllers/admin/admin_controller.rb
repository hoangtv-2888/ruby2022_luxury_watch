class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  layout "admin"

  private
  def handle_err obj
    return if obj.present?

    flash[:warning] = t "not_found"
    redirect_to admin_root_path
  end
end
