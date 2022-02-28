class Ability
  include CanCan::Ability

  def initialize user
    can :read, Product

    return unless user

    can :mange, User, id: user.id
    can %i(read create destroy), CommentRate, user_id: user.id
    can %i(read create update), Order, user_id: user.id

    return unless user.admin?

    can :manage, :all
  end
end
