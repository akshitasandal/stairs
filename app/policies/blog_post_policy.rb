class BlogPostPolicy < ApplicationPolicy
  
  attr_reader :current_user, :blog_post
  
  def initialize(current_user, blog_post)
    @current_user = current_user
    @blog_post = blog_post
  end
  
  def show?
    # if is_user? && @blog_post.company.user_id == @current_user.id 
    #   true
    # elsif is_admin? && @blog_post.company.user_id == @current_user.id 
    #   true
    # elsif is_manager? && @blog_post.company.user_id == @current_user.id
    #   true
    # elsif is_super_admin? 
    #   true
    # else
    #   false
    # end
  end
  
  def index?
    false
  end
  
  def create?
    if @current_user.present?
      if @current_user.role_id == "1" || "4"
        true
      end
    end
  end
   
  def new?
    create?
  end
   
  def edit?
    create?
  end
   
  def destroy?
    create?
  end
end
