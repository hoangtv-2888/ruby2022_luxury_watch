class Admin::UsersController < Admin::AdminController
  before_action :find_user_by_id, only: %i(show update)

  def index
    @pagy, @users = pagy User.newest, items: Settings.pag_10
  end

  def update
    @user.activated? ? @user.unactivate : @user.activate
    respond_to do |format|
      format.html{redirect_to @admin_root_path}
      format.js
    end
  end

  def show; end
end
