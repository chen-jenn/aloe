class IndividualPlant < ApplicationRecord
  belongs_to :user
  validates :species_name, :individual_name, presence: true

  mount_uploader :photo, ImageUploader


  def get_water_freq(user_zone, plant_zone)
    (ZoneComparison.where({ user_zone: user_zone, plant_zone: plant_zone }).pluck :water_freq)[0]
  end

  def get_ranking
    # average of all existing rankings for that particular plant
  end

  def get_sunlight(plant) # usage: get_sunlight(@individual_plant.species_name)
    (Plant.where({ species_name: plant }).pluck :sunlight)[0]
  end

  def get_optimal_temp(plant)
    min = (Plant.where({ species_name: plant }).pluck :temp_min)[0]
    max = (Plant.where({ species_name: plant }).pluck :temp_max)[0]
    "#{min}-#{max}"
  end

end
