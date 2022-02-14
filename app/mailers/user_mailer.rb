class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: @user.email, subject: t("user.account_activation")
  end

  def password_reset user
    @user = user
    mail to: @user.email, subject: t("user.password_reset")
  end

  def approve_order user
    @user = user
    mail to: @user.email, subject: t("admin.approve_order")
  end
end
