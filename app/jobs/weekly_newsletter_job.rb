# class WeeklyNewsletterJob < ActiveJob::Base
# 	 # self.queue_adapter = :resque
#   queue_as :default
#   def perform(user)
#   	# reschedule_job
#   	 WeeklyNewsletter.newsletter_email(user).deliver_now
#     # Do something later
#   end

#   def reschedule_job
#     self.class.set(wait: 1.minute.from_now).perform_later
 
#   end

# end
