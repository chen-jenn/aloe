class RecurringEventsController < ApplicationController
  def create
    @recurring_event = RecurringEvent.new recurring_event_params
    @individual_plant = @recurring_event.individual_plant

    if @recurring_event.save?
      flash[:success] = "Recurring event saved"
      redirect_to individual_plant_path(@individual_plant)
    else
      redirect_to individual_plant_path(@individual_plant)
    end
  end

  def destroy
  end 

  private
  def recurring_event_params
    params.require(:recurring_event).permit(:day, :time, :reminder)
  end
end
