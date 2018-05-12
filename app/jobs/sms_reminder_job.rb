class SmsReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder) #takes the reminder object (one reminder record)
    # checking if and sending if it needs to be sent
    # the send_text method is going to be used here

    # i = Reminder.find(reminder.id).individual_plant
    #
    # if reminder.frequency # == 'once a week' && (last_reminder + 7) >
    #   send_text(i)
    #   Reminder.find(reminder).last_reminder = Time.now
    # elsif reminder.frequency == 'twice a week'
    #
    # elsif reminder.frequency == 'every other day'
    # end
    puts reminder  
  end
end
