# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(user)
      user ||= User.new 
      
      if user.is_admin?
      can :manage, :all
      end
      
      alias_action :create, :read, :update, :destroy, to: :crud
      
      can(:crud, Post) do |post|
      post.user == user
      end
      
      can(:crud, Comment) do |comment|
      comment.user == user
      end
      


    end
  end

end