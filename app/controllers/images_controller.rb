class ImagesController < ApplicationController

  #ability to delete images right on the plant show page
  def create
    @image = Image.new(image_params)
    @plant = Plant.find params[:plant_id]
    @image.plant = @plant

    if @image.save
      redirect_to plant_path(@plant)
    else
      flash[:alert] = "Image did not save"
    end
  end

  def destroy
    image = Image.find params[:id]
    image.destroy
    redirect_to plant_path(image.plant)
  end

  private

  def image_params
    params.require(:image).permit(:file, :description)
  end
end
