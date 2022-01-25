class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user,
                :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    @pa = params[:password_reset][:email]
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "email_sent_reset_password"
      redirect_to root_url
    else
      flash.now[:danger] = t "email_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("cannot_blank")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t "password_reseted"
      redirect_to root_url
    else
      flash[:danger] = t "reset_failed"
      render :edit
    end
  end

  def edit; end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "error.user.not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "reset_expired"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
