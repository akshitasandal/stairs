class CompanyPolicy < ApplicationPolicy
  
  attr_reader :user, :company
  
  def initialize(user, company)
    @user = user
    @company = company
  end
  
  def search?
    true
  end
  
  def create?
    if @user.present?
      if @user.role_id == "1"
        true
      end
    end
  end

  
  def new?
    create?
  end
  
  def show?
    true
  end 
    
  def edit?
    create?
  end
  
  def destroy?
    edit?
  end
  
end
