class User < ApplicationRecord
  has_many :plants, dependent: :nullify
  has_many :individual_plants, dependent: :destroy
  has_secure_password

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :username,
    presence: true,
    uniqueness: true,
    format: { with: VALID_USERNAME_REGEX, message: 'No special characters, only letters, numbers, and daashes and is between 5-20 characters' }

  validates :first_name, :last_name, :city, :country, presence: true

  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX

  geocoded_by :location
  before_validation :geocode

  def location
    if city && city!= 'N/A' && countries.length > 0
      geocoded = "#{city}, #{countries[0].country_name}"
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
