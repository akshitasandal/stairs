class Admin::BlogPostPolicy < ApplicationPolicy
  attr_reader :current_user, :blog_post

  def initialize(current_user, blog_post)
    @current_user = current_user
    @blog_post = blog_post.is_a?(Array) ? blog_post.last : blog_post
  end

  def show?
    true
  end

  def index?
    if is_super_admin?
      true
    elsif current_user.company_id == @blog_post.company_id
      true
    else
      false
    end
  end

  def create?
    new?
  end

  # Super Admin can create posts for any company
  # Admin, Managers and Users can create posts for their company
  def new?
    if is_super_admin? || current_user.company_id == @blog_post.company_id
      true
    else
      false
    end
  end

  # Superadmin can edit all posts
  # Admin can edit all the posts for their comapanies
  # Managers can edit all company specific posts
  # Users can only edit their own posts
  def edit?
    if is_super_admin?
      true
    elsif is_admin? && is_company_owner?(@blog_post.company_id)
      true
    elsif is_manager? && current_user.company_id == @blog_post.company_id
      true
    elsif is_user? && @blog_post.user_id == current_user.id
      true
    else
      false
    end
  end

  def destroy?
    edit?
  end
end
