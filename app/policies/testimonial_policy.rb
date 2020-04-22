# class TestimonialPolicy < ApplicationPolicy
#   attr_reader :user,:testimonial
  
#   def initialize(user, testimonial)
#     @user = user
#     @testimonial = testimonial
#   end
  
#   def index?
#     true
#   end
  
#   def show?
#     true
#   end
  
#   def create?
#     if @user.present?
#       if @user.role_id == "1"
#         true
#       # else
#       #   @company = Company.find(@testimonial.company_id)
#       #   @company_owner = @company.user
#       #   @company_owner.id == @user.id ? true : false
#       end
#     end
#   end
  
#   def new?
#     create?
#     #keep an eye on this one, for superadmin case
#   end
  
#   def edit?
#     create?
#   end
  
#   def destroy?
#     create?
#   end
  
  
# end