class Country < ApplicationRecord
  #make it once and don't need to edit, no one can edit this list or is on very rare occasions
  validates :country_name, presence: true

  has_many :plant_countries, dependent: :destroy #removing a plant-country relation IF a country were removed. Countries should not ever be destroyed
  has_many :plants, through: :plant_countries
end
