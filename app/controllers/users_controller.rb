class UsersController < ApplicationController
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

  def update
    if @user.update user_params
      flash[:success] = t "user.profile_updated"
      redirect_to @user
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
end
