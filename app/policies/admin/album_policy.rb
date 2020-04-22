class Admin::AlbumPolicy < ApplicationPolicy
 
  attr_reader :current_user, :album
  
  def initialize(current_user, album)
    @current_user = current_user
    @album = album.is_a?(Array) ? album.last : album
  end
  
  def show?
   create?
  end
  
  def index?
    return (is_super_admin? || is_admin?) ? true : false
  end
  
  def create?
    new?
  end
   
  def new?
    index?
  end
   
  def edit?
    create?
  end
   
  def destroy?
    create?
  end
  
  def update?
    edit?
  end


end