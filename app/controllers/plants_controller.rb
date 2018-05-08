class PlantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_plant, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    # @plants = Plant.order(species_name: :asc)
    @plants = Plant.search(params[:term])
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

  def create 
    @plant = Plant.new plant_params
    @plant.user = current_user

    # #it's ok to have a plant without a climate_zone field
    if @plant.save
      flash[:success] = 'Plant added!'
      redirect_to plant_path(@plant)
    else
      flash[:alert] = "Error occurred"
      render :new
    end
  end

  def edit
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

  #only users with admin rights permitted
  def destroy
    @plant.destroy
    redirect_to plants_path
  end

  private
  def find_plant
    @plant = Plant.find params[:id]
  end

  def plant_params
    params.require(:plant).permit([
      :term,
      :species_name,
      :common_name,
      :city,
      :climate_zone,
      :notes,
      :sunlight,
      :temp_min,
      :temp_max,
      { country_ids: [] },
      image_attributes: [:description, :file],
      common_names_attributes: [:id, :name] ]
    )
  end

  def authorize_user!
    unless can?([:create, :read, :update], @plant)
      flash[:alert] = 'Access Denied'
      redirect_to plant_path(@plant)
    end
  end
end
