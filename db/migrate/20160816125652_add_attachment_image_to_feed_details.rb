class AddAttachmentImageToFeedDetails < ActiveRecord::Migration
  def self.up
    change_table :feed_details do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :feed_details, :image
  end
end
