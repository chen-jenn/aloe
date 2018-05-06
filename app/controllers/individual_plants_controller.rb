class IndividualPlantsController < ApplicationController
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
  end

  def destroy
  end

  private
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
