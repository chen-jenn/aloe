class Plant < ApplicationRecord
  has_many :plant_countries, dependent: :destroy #plant record destroyed removes the plant_country relation
  has_many :countries, through: :plant_countries

  before_validation :capitalize
  validates :species_name, presence: true, uniqueness: true
  validates :common_name, presence: true

  private
  def capitalize
    species_name.capitalize!
    city.titleize
  end
end
