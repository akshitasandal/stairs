class AlbumPolicy < ApplicationPolicy
  
  attr_reader :user, :album
  
  def initialize(user, album)
    @user = user
    @album = album
  end
  
  def show?
    true
  end
  
  def index?
    false
  end
  
  def create?
    if @user.role_id == "1"
        true
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
