class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :image
  belongs_to :album
  belongs_to :company
  belongs_to :blog_post
  belongs_to :view_type
  
  #Add views
  def self.track_view(data)
    @view = View.new
    @view_type = ViewType.find_by_name(data[:type])
    @view.ip_address = data[:ip]
    @view.user_id = data[:user]
    @view.view_type_id = @view_type.id
    @view.object_id  = data[:object_id]
    @view.save
  end
end