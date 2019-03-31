class Company < ApplicationRecord

  has_many :departments, dependent: :destroy
  has_many :users, through: :departments

  validates_presence_of :name

  def top_employees
    departments.joins(
      <<~SQL
        join lateral (
        select * from users
        where department_id = departments.id
        order by salary desc
        limit 3
        ) u on true
      SQL
    ).order(:name).select('departments.*, u.*')
  end
end
