class CreateUserNotificationPreferences < ActiveRecord::Migration
  def change
    create_table :user_notification_preferences do |t|
    	t.integer :notification_type_id
    	t.integer :user_id
    	t.boolean :status , :default => 0
      t.timestamps null: false
    end
  end
end
