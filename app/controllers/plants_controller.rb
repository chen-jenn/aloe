class PlantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_plant, only: [:show, :edit, :update, :destroy, :rank_count]
  before_action :authorize_user!, only: [:edit, :update] # only admins allowed to destroy

  def index
    # @plants = Plant.order(species_name: :asc)
    @plants = Plant.paginate(:page => params[:page], :per_page => 12).search(params[:term])
  end

  def show
    @countries = @plant.countries
    @common_names = @plant.common_names
    @images = @plant.images.all
    @rank = rank_count
  end

  def new
    @plant = Plant.new
    @common_name = @plant.common_names.build
    @image = @plant.images.build
    # @images = @plant.images.all.order('id desc')
  end

  def create
    @plant = Plant.new plant_params
    @plant.user = current_user
    #it's ok to have a plant without a climate_zone field

    if @plant.save
      flash[:success] = 'Plant added!'
      redirect_to plant_path(@plant)
    else
      flash[:alert] = "Plant did not save"
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


  def destroy
    if current_user.is_admin?
      @plant.destroy
      redirect_to plants_path
    else
      flash[:alert] = "Only admins can delete"
      redirect_to plant_path(@plant)
    end
  end

  private
  def rank_count
    def helper(rank)
      @plant.rankings.where({ease_of_care: rank}).count
    end

    easy = helper('easy')
    moderate = helper('moderate')
    hard = helper('hard')

    tallied = [easy, moderate, hard]

    if tallied.max == easy
      'easy'
    elsif tallied.max == moderate
      'moderate'
    elsif tallied.max == hard
      'hard'
    end
  end

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
      images_attributes: [:id, :plant_id, :description, :file],
      common_names_attributes: [:id, :name, :_destroy] ]
    )
  end

  def authorize_user!
    unless can?(:crud, @plant)
      flash[:alert] = 'Access Denied'
      redirect_to plant_path(@plant)
    end
  end
end
