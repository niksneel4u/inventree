class EntityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      admin_user? ? scope : (raise Pundit::NotAuthorizedError)
    end
  end

  def new?
    admin_user?
  end

  def create?
    admin_user?
  end

  def index?
    admin_user?
  end

  def edit?
    return false if default_entity?
    admin_user?
  end

  def destroy?
    return false if default_entity?
    admin_user?
  end

  def update?
    return false if default_entity?
    admin_user?
  end

  private

  def default_entity?
    Entity::NON_DELETABLE_ENTITIES.include?(record.name)
  end

end
