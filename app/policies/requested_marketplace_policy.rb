# frozen_string_literal: true

class RequestedMarketplacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      admin_user? ? scope : (raise Pundit::NotAuthorizedError)
    end
  end

  def new?
    client_user?
  end

  def create?
    client_user?
  end

  def destroy?
    admin_user?
  end
end
