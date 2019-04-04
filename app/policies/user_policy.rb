class UserPolicy < ApplicationPolicy

  def permitted_attributes
    attributes = [:phone, :address, :email]

    if user.administrator?
      attributes += [:salary, :bonus, :department_id]
    end

    if is_own_profile?
      attributes += [:password, :password_confirmation]
    end

    attributes
  end

  def show?
    if user.administrator?
      true
    else
      is_own_profile?
    end
  end

  def update?
    show?
  end

  private

  def record_belongs_to_users_company?
    record.company == users_company
  end

  def is_own_profile?
    user == record
  end
end
