class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.id == 1
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
    elsif user.id.present?
      can :read, :all
      can :create, [Alert, Answer, Comment, Product, Question, Review, Similar, Vote]
      can [:update, :destroy], [Alert, Answer, Comment, Question, Review, Vote], :user_id => user.id
      can [:update, :destroy], User, :id => user.id
    else
      can :read, :all
    end
  end
end
