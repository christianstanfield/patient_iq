class ApplicationPolicy

  attr_reader :user, :record, :users_company

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user          = user
    @record        = record
    @users_company = user.company

    raise Pundit::NotAuthorizedError unless record_belongs_to_users_company?
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
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
