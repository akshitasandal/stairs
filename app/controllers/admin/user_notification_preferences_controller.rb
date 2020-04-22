class Admin::UserNotificationPreferencesController < Admin::AdminController
	
	def edit_multiple 
		if !current_user.user_notification_preferences.present? && !is_super_admin?
			default_notification_preferences
		elsif !is_super_admin?
			notifications = UserNotificationPreference.where(:user_id => current_user.id).pluck(:id)
			@notification = UserNotificationPreference.find(notifications)
		end
	end

	def update
		@notifications = UserNotificationPreference.where(:user_id => current_user.id)
		status = params["/dashboard/user/preferences/update"].values
		@notifications.zip(status).each do |notification,status|
			notification.update(:status => status)
		end
		redirect_to edit_multiple_admin_user_notification_preferences_path
	end

	private
		def default_notification_preferences
		user_preferences_array = [ { :notification_type_id => "1", :status =>  "1", :user_id => current_user.id},
															{ :notification_type_id =>  "2", :status => "1", :user_id => current_user.id},
														{ :notification_type_id =>  "3", :status => "1", :user_id => current_user.id},
													{ :notification_type_id =>  "4", :status => "1", :user_id => current_user.id},
												{ :notification_type_id =>  "5", :status => "1", :user_id => current_user.id},
											{ :notification_type_id => "6", :status => "1", :user_id => current_user.id},
										] 
		UserNotificationPreference.create(user_preferences_array)
	end
end
