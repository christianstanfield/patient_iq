class NilClassPolicy < ApplicationPolicy

  def record_belongs_to_users_company?
    false
  end

  class Scope < Scope

    def resolve
      raise Pundit::NotDefinedError, 'Cannot scope NilClass'
    end
  end
end
