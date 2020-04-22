class Admin::UserPolicy < ApplicationPolicy

  attr_reader :user , :users

  def initialize(user , users)
    @user = user
    @users = users
  end

  def index
    (is_super_admin? || is_admin?) ? true : false
  end

  def show?
    true
  end

  def new?
    (is_super_admin? || is_admin?) ? true : false
  end

  def create?
    new?
  end

  # Superadmins can edit any category
  # Rest people can edit their categories
  def edit?
    if new? 
      true
    else
      false
    end
  end

  def destroy?
    edit?
  end

end
