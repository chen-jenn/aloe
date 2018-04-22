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
    @plant.common_names.new
  end

  def create #after the plant with valid parameters gets sent and saved to the database, the application should then populate the climate_zone field
    #do the update/patch before rendering the page so that when it is directed to show page, the field will be populated
    @plant = Plant.new plant_params
    # @image = Image.new

    if @plant.save
      # if params[:files]
      #   params[:files].each {|file|
      #     @plant.images.create(file: file)
      #   }
      # end
      flash[:success] = 'Plant added!'
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  def edit
  end

  def update #only admins, moderators, or the user that created it
    if @plant.update plant_params
      flash[:notice] = "Record updated"
      redirect_to plant_path(@plant)
    else
      flash[:alert] = "Error occurred"
      render :edit
    end
  end

  def destroy #only moderators or admins permitted
    @plant.destroy
    redirect_to plants_path
  end

  private
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
      image_attributes: [:file_file_name],
      common_names_attributes: [:name] ])
  end
end
