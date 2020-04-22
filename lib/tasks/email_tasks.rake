desc 'send newsletter email'
task send_newsletter_email: :environment do
  # ... set options if any
  @super_admin = User.find_by(:role_id => 1)
  if @super_admin.newsletter_enable_status == true
	  @user = User.select("users.*, user_notification_preferences.status status").joins("LEFT JOIN user_notification_preferences ON user_notification_preferences.user_id = users.id WHERE user_notification_preferences.status = 1 AND user_notification_preferences.notification_type_id = 6")
	  # puts @user
	  @user.each do|user|
		#   # unsubscribe = Rails.application.message_verifier(:unsubscribe).generate(user.id)
		  WeeklyNewsletter.newsletter_email(user).deliver_now!
		end
	end
end	