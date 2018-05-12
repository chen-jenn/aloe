class RemindersController < ApplicationController
    before_action :authorize_user!, only: [:create, :destroy]

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
    r = Reminder.find params[:id]
    r.destroy
    redirect_to user_path(r.user)
  end

  private
  def authorize_user!
    @reminder = Reminder.find params[:id]
    unless can?(:crud, @reminder)
      flash[:alert] = 'Access Denied'
      redirect_to plant_path(@reminder)
    end
  end

end
