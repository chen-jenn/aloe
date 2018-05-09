class IndividualPlantsController < ApplicationController
  before_action :find_individual_plant, only: [:edit, :update, :destroy]

  def new
    @individual_plant = IndividualPlant.new
  end

  def create
    @individual_plant = IndividualPlant.new individual_plant_params
    @individual_plant.user = current_user

    if @individual_plant.save
      redirect_to user_path(@individual_plant.user)
    else
      flash[:alert] = 'Error occurred'
    end
  end

  def edit
  end

  def update
    if @individual_plant.update individual_plant_params
      redirect_to user_path(@individual_plant.user)
    else
      flash[:alert] = "Error occurred"
      render :edit
    end
  end

  def destroy
    @individual_plant.destroy
    redirect_to user_path(@individual_plant.user)
  end

  def generate_data # like editing something, patch
    i = IndividualPlant.find params[:id]
    # i.water_frequency = get_water_freq()
    # i.ranking = get_ranking(i.species_name)
    i.sunlight = get_sunlight(i.species_name)
    i.optimal_temp = get_optimal_temp(i.species_name)
    i.save
  end

  # # After clicking 'Generate watering schedule!', a pop-up should say how often they should water this specific plant and automatically set that time frame starting from the day they clicked the button
  # def get_water_freq(user_zone, plant_zone)
  #   (ZoneComparison.where({ user_zone: user_zone, plant_zone: plant_zone }).pluck :water_freq)[0]
  # end
  #
  # def get_ranking
  #   # average of all existing rankings for that particular plant
  # end
  #
  # def get_sunlight(plant) # usage: get_sunlight(@individual_plant.species_name)
  #   (Plant.where({ species_name: plant }).pluck :sunlight)[0]
  # end
  #
  # def get_optimal_temp(plant)
  #   min = (Plant.where({ species_name: plant }).pluck :temp_min)[0]
  #   max = (Plant.where({ species_name: plant }).pluck :temp_max)[0]
  #   "#{min}-#{max}"
  # end

  private

  def find_individual_plant
    @individual_plant = IndividualPlant.find params[:id]
  end

  def individual_plant_params
    params.require(:individual_plant).permit([
      :species_name,
      :common_name,
      :individual_name,
      :description,
      :photo
      ])
  end

end
