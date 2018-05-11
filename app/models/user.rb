class User < ApplicationRecord
  has_many :rankings, dependent: :nullify
  has_many :ranked_plants, through: :rankings, source: :plant
  has_many :plants, dependent: :nullify
  has_many :individual_plants, dependent: :destroy
  has_secure_password

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :username,
    presence: true,
    uniqueness: true,
    format: { with: VALID_USERNAME_REGEX, message: 'No special characters, only letters, numbers, and dashes and is between 5-20 characters' }

  validates :first_name, :last_name, :city, :country, :latitude, :longitude, presence: true

  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX

  geocoded_by :location
  before_validation :geocode
  after_validation :send_request

  def location
      "#{city}, #{country}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_request
    if latitude && longitude
      response = RestClient::Request.execute(
        method: :get,
        url: "http://climateapi.scottpinkelman.com/api/v1/location/#{latitude}/#{longitude}"
      )
      parsed = JSON.parse(response)
      self.climate_zone = parsed["return_values"][0]["koppen_geiger_zone"]
    else
      p "Unable to get geocoding location"
    end
  end

end
