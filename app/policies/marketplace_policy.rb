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
end
