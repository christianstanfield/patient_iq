class Department < ApplicationRecord
  audited associated_with: :company

  belongs_to :company
  has_many   :users, dependent: :destroy

  validates_presence_of :name
end
