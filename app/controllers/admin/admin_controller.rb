class Admin::AdminController < ApplicationController
  before_action :check_login, :check_admin

  layout "admin"
end
