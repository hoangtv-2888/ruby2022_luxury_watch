class Admin::AdminController < ApplicationController
  before_action :check_login, :check_amin

  layout "admin"
end
