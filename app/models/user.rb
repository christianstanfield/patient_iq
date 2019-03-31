class User < ApplicationRecord
  has_secure_password

  belongs_to :department

  validates_presence_of :first_name, :last_name, :phone, :address,
                        :email, :salary, :bonus, :role
  validates :phone, length: { is: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }

  before_validation :format_phone_number

  def format_phone_number
    phone&.gsub!(/\D/, '')
  end

  enum role: {
    employee:      10,
    administrator: 20
  }
end
