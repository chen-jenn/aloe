class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :update, :read, :destroy, to: :manage_self

    can(:crud, Plant) do |plant|
      user == plant.user
    end

    can(:manage_self, User) do |u|
      u == user
    end

    can(:crud, IndividualPlant) do |plant|
      user == plant.user
    end

    can(:crud, Reminder) do |reminder|
      user == reminder.user 
    end
  end
end
