class Department < ApplicationRecord

  belongs_to :company
  has_many   :users, dependent: :destroy

  validates_presence_of :name
end
