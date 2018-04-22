class ImagesController < ApplicationController

  def create
    @plant = Plant.find params[:plant_id]
    @image = Image.new image_params
    @image.plant = @plant

    if @image.save
      redirect_to plant_path(@plant)
    else
      render plain: "image did not save"
    end
  end

  def destroy
    image = Image.find params[:id]
    image.destroy
    redirect_to plant_path(image.plant)
  end

  private
  def image_params
    params.require(:image).permit(:file)
  end
end
