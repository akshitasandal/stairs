class Admin::RolePolicy < ApplicationPolicy
attr_reader :current_user, :role
  
  def initialize(current_user, role)
    @current_user = current_user
    @role = role
  end
  def assign?
    index?
  end
  
  def show?
    index?
  end
  
  def index?
    return is_super_admin? ? true : false
  end
  
  def show_roles?
   index?
  end

end