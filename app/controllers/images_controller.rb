class ImagesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_image, only: [:show]
  
  # GET /images
  def create
    
  end
  
  # GET /images/:id
  def show
    @data = {:type => "photo_view",:object_id => @image.id, :ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
    render json: @view
  end
  
  # image identification
  def set_image
    @image = Image.find( params[:id] )
  end

    
end


