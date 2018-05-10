class Plant < ApplicationRecord
  belongs_to :user

  has_many :rankings, dependent: :destroy
  has_many :rankers, through: :rankings, source: :user
  has_many :common_names, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :plant_countries, dependent: :destroy
  has_many :countries, through: :plant_countries

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :common_names, reject_if: :all_blank, allow_destroy: true

  validate :has_at_least_one_country
  validates :species_name, presence: true, uniqueness: true
  validates :latitude, :longitude, :sunlight, presence: true
  validates_length_of :climate_zone, maximum: 3, allow_blank: true
  validates_associated :common_names
  validates_associated :images

  geocoded_by :location
  before_validation :geocode
  before_validation :capitalize
  after_validation :send_request

  def location #need to account for inaccurate city-country combos (if you type something like Seattle, China, it will just geocode Seattle)
    if city && city!= 'N/A' && countries.length > 0
      geocoded = "#{city}, #{countries[0].country_name}"
    end
  end

  def self.search(term)
    if term
      where('species_name ILIKE ?', "%#{term}%").order('species_name ASC')
    else
      order('species_name ASC')
    end
  end


  private
  #to populate the climate_zone column before saving record
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

  def capitalize
    species_name.capitalize!
    city.titleize
  end

  def has_at_least_one_country
    if countries.empty?
      errors.add(:plant, "needs at least one country")
    end
  end

end
