class Company < ApplicationRecord

  has_many :departments, dependent: :destroy
  has_many :users, through: :departments

  validates_presence_of :name
end
