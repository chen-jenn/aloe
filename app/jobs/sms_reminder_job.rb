class SmsReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder) # Takes the reminder object (one reminder record) as argument
    # Checking the reminder record and sending if it needs to be sent
    i = Reminder.find(reminder.id).individual_plant

    if reminder.frequency == 'once a week' && (reminder.last_reminder + 60*60*24*7) > Time.now
      i.send_text(i)
      reminder.last_reminder = Time.now
      reminder.save
    elsif reminder.frequency == 'twice a week' && (reminder.last_reminder + 60*60*24*7) > Time.now
      i.send_text(i)
      reminder.last_reminder == Time.now
      reminder.save
    elsif reminder.frequency == 'every other day' && (reminder.last_reminder + 60*60*24*2) > Time.now
      i.send_text(i)
      reminder.last_reminder == Time.now
      reminder.save
    end

  end
end
