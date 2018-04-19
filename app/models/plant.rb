class Plant < ApplicationRecord
  before_validation :capitalize
  validates :species_name, :country, :climate_zone, presence: true

  private
  def capitalize
    species_name.capitalize!
    city.titleize
    country.titleize
  end
end
