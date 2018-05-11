class SmsReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder) #takes the reminder object (one reminder record)
    # checking if and sending if it needs to be sent
    # the send_text method is going to be used here
  end
end
