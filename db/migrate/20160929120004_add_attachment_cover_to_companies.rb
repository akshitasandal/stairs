class AddAttachmentCoverToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :companies, :cover_photo
  end
end
