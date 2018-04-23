class User < ApplicationRecord
  has_many :plants, dependent: :nullify 
  has_secure_password

  validates :username,
    presence: true,
    uniqueness: true,
    format: { with: /^[a-z0-9][-a-z0-9]{4,19}$/i, message: 'No special characters, only letters, numbers, and daashes and is between 5-20 characters' }

  validates :first_name, :last_name, :city, :country, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end
end
