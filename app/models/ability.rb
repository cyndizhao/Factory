class Ability < ApplicationRecord
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    can [:edit, :destroy], Idea do |idea|
      idea.user == user
    end

    can [:destroy], Review do |review|
      review.user == user
    end

  end
end
