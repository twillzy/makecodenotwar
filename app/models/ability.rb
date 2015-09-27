class Ability
  include CanCan::Ability

  def initialize(user)

    # Can only go to the update page if the current user is you.
    can :update, User do |u|
        u == user
    end    

    can :read, User do |u|
        u == user
    end  

  end
end