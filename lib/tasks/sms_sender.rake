namespace :sms_sender do
  task :send_all do
    SmsReminder.all.each  do |reminder|
      SmsReminderJob.perform_later(reminder)
    end
  end
end

# rake is what loops through  the reminder table and does the scheduling
# every hour, this will go through all the records in the reminders table to see if a message needs to be sent out

# cmd command:
# rake sms_sender:send_all
# eventually can just set the command to run every hour or so (linux crono)
