class PlantCountry < ApplicationRecord
  belongs_to :plant
  belongs_to :country
end
