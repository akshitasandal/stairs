class NotificationType < ActiveRecord::Base
	has_many :user_notification_preferences
end
