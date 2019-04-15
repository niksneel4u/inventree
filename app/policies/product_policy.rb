# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      client_user? ? scope : (raise Pundit::NotAuthorizedError)
    end
  end

  def new?
    client_user?
  end

  def create?
    client_user?
  end

  def destroy?
    client_user?
  end

  def show?
    client_user?
  end

  def audits?
    client_user?
  end

  def fetch_latest_data?
    client_user?
  end
end
