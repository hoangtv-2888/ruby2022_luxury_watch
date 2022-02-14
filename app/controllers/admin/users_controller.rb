class Admin::UsersController < Admin::AdminController
  before_action :find_user_by_id, only: %i(show update)
  before_action :load_search_user, only: %i(search)

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

  def search
    respond_to do |format|
      format.html{redirect_to @admin_root_path}
      format.js
    end
  end

  private
  def load_search_user
    @users = User.search_by_name(params[:name]).newest
    return if @users.present?

    flash[:warning] = t "not_found"
    if request.xhr?
      render(js: "window.location = '#{admin_root_path}'") && return
    else
      redirect_to admin_root_path
    end
  end
end
