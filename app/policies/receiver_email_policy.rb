# frozen_string_literal: true

class ReceiverEmailPolicy < ApplicationPolicy
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

  def edit?
    client_user?
  end

  def update?
    client_user?
  end
end
