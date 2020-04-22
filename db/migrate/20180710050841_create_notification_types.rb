class CreateNotificationTypes < ActiveRecord::Migration
  def change
    create_table :notification_types do |t|
    	t.string :name
    	t.string :label
    	t.boolean :status , :default => 0
      t.timestamps null: false
    end
  end
end
