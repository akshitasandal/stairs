class ApplicationPolicy
  include ApplicationHelper
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record.is_a?(Array) ? record[-1] : record
  end

  def index?  
    return is_super_admin? ? true : false
  end
  
  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def scope
    Pundit.policy_scope!(current_user, record.class)
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope.is_a?(Array) ? scope[-1] : scope
    end

    def resolve
      scope
    end
  end
end
