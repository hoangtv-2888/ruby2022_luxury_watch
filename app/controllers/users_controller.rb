class UsersController < ApplicationController
  before_action :find_user_by_id, :check_user,
                :correct_user, only: %i(edit update)

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_active_mail
      flash[:info] = t "user.check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "user.profile_updated"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password,
                                 :address,
                                 :phone,
                                 :password_confirmation)
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "find_fail"
    redirect_to root_url
  end

  def check_user
    return if @user&.activated

    flash[:danger] = t "user_not_activated"
    redirect_to root_url
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
