class Admin::CompanyPolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :company

  def initialize(current_user, company)
    @current_user = current_user
    @company = company.is_a?(Array) ? company.last : company
  end

  def search?
    true
  end

  def index?
    return (is_super_admin? || is_admin? ) ? true : false
  end

  def create?
    new?
  end

  # Super Admin can create multiple Companies
  # Admin can only create one company
  # No one else can create company
  def new?
    if is_super_admin?
      true
    elsif is_admin? && !has_company?
      true
    else
      false
    end
  end

  def edit?
    if is_super_admin? || @company.user_id == current_user.id
      true
    else
      false
    end
  end

  def update?
    edit?
  end

  def validate_user?
    new?
  end

  def destroy?
    edit?
  end

  def show?
    create?
  end
end
