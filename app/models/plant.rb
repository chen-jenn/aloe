class Plant < ApplicationRecord
  has_many :common_names
  accepts_nested_attributes_for :common_names

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :plant_countries, dependent: :destroy #plant record destroyed removes the plant_country relation
  has_many :countries, through: :plant_countries

  before_validation :capitalize
  validates :species_name, presence: true, uniqueness: true
  validates_associated :common_names

  private
  def capitalize
    species_name.capitalize!
    city.titleize
  end
end
