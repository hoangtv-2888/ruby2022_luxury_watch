class Admin::UsersController < Admin::AdminController
  before_action :load_search_user, only: %i(search)
  before_action :load_with_deleted, only: %i(destroy show)

  def index
    @q = User.ransack(name_cont: params[:q])
    @users = @q.result
    @pagy, @users = pagy @users, items: Settings.pag_10
  end

  def destroy
    @user.deleted? ? @user.restore(recursive: true) : @user.delete
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

  def list_users_delete
    @q = User.ransack(name_cont: params[:q])
    @users = @q.result.only_deleted
    @pagy, @users = pagy @users, items: Settings.pag_10
  end

  private
  def load_search_user
    @q = User.ransack(name_cont: params[:name])
    @users = @q.result
    return if @users.present?

    flash[:warning] = t "not_found"
    if request.xhr?
      render(js: "window.location = '#{admin_root_path}'") && return
    else
      redirect_to admin_root_path
    end
  end

  def load_with_deleted
    @user = User.with_deleted.find_by(id: params[:id])
    return @user if @user

    not_found
  end
end
