class PlantsController < ApplicationController
  before_action :find_plant, only: [:show, :edit, :update, :destroy]

  def index
    @plants = Plant.order(species_name: :asc)
  end

  def show
  end

  def new
    @plant = Plant.new
  end

  def create #after the plant with valid parameters gets sent and saved to the database, the application should then populate the climate_zone field
    #do the update/patch before rendering the page so that when it is directed to show page, the field will be populated
    @plant = Plant.new plant_params

    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  def edit
  end

  def update #only admins and the user that created it
    #keeps rolling back
    if @plant.update plant_params
      redirect_to plant_path(@plant)
    else
      render :edit
    end
  end

  def destroy #only moderators or admins permitted
    @plant.destroy
    redirect_to plant_path
  end

  private
  def find_plant
    @plant = Plant.find params[:id]
  end

  def plant_params
    params.require(:plant).permit([:species_name, :common_name, :city, :notes, { country_ids: [] }])
  end
end
