class CommonNamesController < ApplicationController
  #technically don't need this controller?? creation of common name is during creation of plant record
  def create
    @plant = Plant.find(params[:plant_id])
    @common_name = CommonName.new(common_name_params)
    @common_name.plant = @plant

    if @common_name.save
      redirect_to plant_path(@plant)
    else
      render plain: "common name did not save"
    end
  end

  def destroy
    common_name = CommonName.find params[:id]
    common_name.destroy
    redirect_to plant_path(common_name.plant)
  end

  def update
  end

  private
  def common_name_params
    params.require(:common_name).permit(:name)
  end
end
