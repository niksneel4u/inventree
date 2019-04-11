# frozen_string_literal: true

class MarketplacePolicy < ApplicationPolicy
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
    admin_user?
  end

  def destroy?
    admin_user?
  end

  def update?
    admin_user?
  end

  def add_mappings?
    admin_user?
  end

  def save_mappings?
    admin_user?
  end
end
