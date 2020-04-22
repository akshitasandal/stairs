# class SchedulePostJob < ActiveJob::Base
# 	debugger
#   queue_as :default
# 	  # include SuckerPunch::Job
# 	debugger

#   def perform(blog_post)
# 	debugger
# 	published_at = @arguments[0].published_at
#     # @blog_post = record
#         SchedulePostJob.set(wait_until: published_at)
#         blog_post.update_attributes(:publish => true)

#   end
# # def set(options)
# # 	debugger
# #         ConfiguredJob.new(self, options)
# #       end
# end

