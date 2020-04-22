class UserPolicy < ApplicationPolicy
  
  attr_reader :user , :users
  
  def initialize(user , users)
    @user = user
    @users = users
  end
  
end
