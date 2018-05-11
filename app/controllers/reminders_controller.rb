class RemindersController < ApplicationController
  def create
    i = IndividualPlant.find params[:individual_plant_id]
    @reminder = Reminder.new({last_reminder: Time.now})
    @reminder.user = current_user
    @reminder.individual_plant = i

    if i.water_frequency == 'low'
      @reminder.frequency = 'once a week'
    elsif i.water_frequency == 'med'
      @reminder.frequency = 'twice a week'
    elsif i.water_frequeny == 'high'
      @reminder.frequency = 'every other day'
    end

    if @reminder.save
      redirect_to user_path(@reminder.user)
    else
      flash[:alert] = 'error occurred'
    end
  end

  def destroy
    # removing a reminder
  end

end
