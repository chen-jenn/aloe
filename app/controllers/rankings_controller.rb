class RankingsController < ApplicationController
  before_action :authenticate_user! # must be logged in to rank a plant

  def create
    plant = Plant.find params[:plant_id]
    ranking = Ranking.new(plant: plant, user: current_user, ease_of_care: params[:ease_of_care])
    if ranking.save
      redirect_to plant_path(plant), notice: 'Thanks for your input'
    else
      redirect_to plant_path(plant), alert: 'Already added input'
    end
  end

  def update
    ranking = Ranking.find params[:id]
    ranking.update({ease_of_care: params[:ease_of_care]})
    redirect_to plant_path(ranking.plant), notice: "Input changed"
  end

  def destroy
    ranking = Ranking.find params[:id]
    ranking.destroy
    redirect_to plant_path(ranking.plant), notice: 'Input revoked'

  end
end
