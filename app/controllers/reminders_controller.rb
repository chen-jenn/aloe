class RemindersController < ApplicationController
  def create
    @reminder = Reminder.new

  end

  def destroy
  end

  private
  def reminder_params
    params.require 
  end
end
