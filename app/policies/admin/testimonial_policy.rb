class Admin::TestimonialPolicy < ApplicationPolicy
attr_reader :current_user,:testimonial
  
  def initialize(current_user, testimonial)
    @current_user = current_user
    @testimonial = testimonial.is_a?(Array) ? testimonial.last : testimonial
  end
  
  def index?
    return (is_super_admin? or is_admin? ) ? true : false
  end
  
  def show?
    true
  end
  
  def create?
    new?
  end
  
  def new?
    create?
    #keep an eye on this one, for superadmin case
  end
  
  def edit?
    create?
  end
  
  def destroy?
    create?
  end

end