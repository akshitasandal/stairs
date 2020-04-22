class RenameColumnNameInUsers < ActiveRecord::Migration
  def change
  	rename_column :users , :subscription , :newsletter_enable_status
  end
end
