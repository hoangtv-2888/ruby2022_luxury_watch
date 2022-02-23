module Admin::UsersHelper
  def show_activate user
    t "user.#{user.confirmed? ? 'unactivate' : 'activate'}"
  end
end
