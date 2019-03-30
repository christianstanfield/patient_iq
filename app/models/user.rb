class User < ApplicationRecord
  has_secure_password

  belongs_to :department

  validates_presence_of :first_name, :last_name, :phone, :address,
                        :email, :salary, :bonus
end
