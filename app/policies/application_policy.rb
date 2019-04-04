class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, I18n.t('pundit') unless user
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, I18n.t('pundit') unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    def admin_user?
      user_with_role?(:admin)
    end

    def client_user?
      user_with_role?(:client)
    end

    def user_with_role?(role)
      user.has_role?(role)
    end
  end

  private

  def admin_user?
    user_with_role?(:admin)
  end

  def client_user?
    user_with_role?(:client)
  end

  def user_with_role?(role)
    user.has_role?(role)
  end
end
