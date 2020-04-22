class Image < ActiveRecord::Base
  belongs_to :album
  has_many   :views , :dependent => :destroy
  has_attached_file :image, styles: { medium: "235x200>", thumb: "130x120>", small: "50X45>"}, default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  before_create :default_values
  
  #save ByDefault value for delete.
  def default_values
    self.deleted ||= '0'
  end
  
end