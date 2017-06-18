class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :admin
      can :manage, :groupings
      can :manage, :institutions
      can :manage, :notices
      can :manage, :states
      can :manage, :users
    else
      can :access, :pages
    end
  end
end
