class PlantsController < ApplicationController
  def index
    @plants = Plant.order(species_name: :asc)
  end

  def show
    @plant = Plant.find params[:id]
  end

  def new
    @plant = Plant.new 
  end

  def create
  end

  def edit
  end

  def update #only admins and the user that created it
  end

  def destroy #only moderators or admins permitted
  end
end
