class CompanyPolicy < ApplicationPolicy

  def permitted_attributes
    [:name]
  end

  def show?
    user.administrator?
  end

  def update?
    show?
  end

  private

  def record_belongs_to_users_company?
    record == users_company
  end
end
