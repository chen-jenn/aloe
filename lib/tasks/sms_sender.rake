namespace :sms_sender do
  task :send_all => :environment do
    Reminder.all.each do |reminder|
      SmsReminderJob.perform_later(reminder)
    end
  end
end

# Rake task is looping through  the reminders table and sees which individual_plant's user needs to be sent a reminder
# e.g. every hour, this will go through all the records in the reminders table to see if a message needs to be sent out

# cmd command:
# rake sms_sender:send_all
# 'rails jobs:work' needs to be running in backgroung as well
