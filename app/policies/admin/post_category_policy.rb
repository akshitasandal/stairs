class Admin::PostCategoryPolicy < ApplicationPolicy
  include ApplicationHelper
  attr_reader :current_user, :post_category

  def initialize(current_user, post_category)
    @current_user = current_user
    @post_category = post_category.is_a?(Array) ? post_category.last : post_category
  end

  def index
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  # Superadmins can edit any category
  # Rest people can edit their categories
  def edit?
    if is_super_admin? || current_user.id == post_category.user_id
      true
    else
      false
    end
  end

  def destroy?
    edit?
  end

end
