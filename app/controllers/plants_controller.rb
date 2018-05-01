class PlantsController < ApplicationController
  before_action :find_plant, only: [:show, :edit, :update, :destroy]

  def index
    @plants = Plant.order(species_name: :asc)
  end

  def show
    @countries = @plant.countries
    @common_names = @plant.common_names
    @images = @plant.images
  end

  def new
    @plant = Plant.new
    @common_name = @plant.common_names.new
  end

  def create #after the plant with valid parameters gets sent and saved to the database, the application should then populate the climate_zone field
    #do the update/patch before rendering the page so that when it is directed to show page, the field will be populated
    @plant = Plant.new plant_params
    @plant.user = current_user
    @plant.climate_zone = climate_api_response

    if @plant.save
      flash[:success] = 'Plant added!'
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  def edit
    # but you need options to give multiple common names
    @plant.common_names.build unless @plant.common_names.any?
  end

  #only admins, moderators, or the user that created it
  def update
    if @plant.update plant_params
      flash[:notice] = "Record updated"
      redirect_to plant_path(@plant)
    else
      flash[:alert] = "Error occurred"
      render :edit
    end
  end

  #only moderators or admins permitted
  def destroy
    @plant.destroy
    redirect_to plants_path
  end

  private

  def climate_api_response
    #convert city and country into lat and long using geocoder?
    lat = 40.8539645
    long = 14.1765625
    # make request
    response = RestClient::Request.execute(
      method: :get,
      url: "http://climateapi.scottpinkelman.com/api/v1/location/#{lat}/#{long}"
    )
    parsed = JSON.parse(response)
    # extract climate zone data from json response
    parsed["return_values"][0]["koppen_geiger_zone"]
  end

  def find_plant
    @plant = Plant.find params[:id]
  end

  def plant_params
    params.require(:plant).permit([
      :species_name,
      :common_name,
      :city,
      :climate_zone,
      :notes,
      { country_ids: [] },
      image_attributes: [:id, :description, :file_file_name],
      common_names_attributes: [:id, :name] ])
  end
end
