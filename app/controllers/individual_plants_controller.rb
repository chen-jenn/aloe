class IndividualPlantsController < ApplicationController
  before_action :find_individual_plant, except: [:new, :create]

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

  def generate_data
    i = IndividualPlant.find params[:id]
    i.water_frequency = i.get_water_freq(i.user.climate_zone, i.species_name)
    i.ranking = i.get_ranking
    i.sunlight = i.get_sunlight(i.species_name)
    i.optimal_temp = i.get_optimal_temp(i.species_name)
    i.save
    redirect_to user_path(i.user)

    # After clicking 'Generate watering schedule!', a pop-up should say how often they should water this specific plant and automatically set that time frame starting from the day they clicked the button
    # set reminder timer
  end

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
      :photo,
      # app generated
      :ranking,
      :water_frequency,
      :sunlight,
      :optimal_temp
      ])
  end

end
