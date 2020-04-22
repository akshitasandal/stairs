class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :set_company
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => :show
  
  # GET /albums
  # GET /albums.json
  def index
    @albums =  authorize Album.where(:deleted => 0)    
  end
 
  # GET /albums/1
  # GET /albums/1.json
  def show
    @images = @album.images
    @data = {:type => "album_view",  :object_id => @album.id , :ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
  end

  
  private
  
  # Use Callback to share common setup or constraints between actions.
  def set_album
    @album = Album.find_by_param(params[:id])
  end
  
  # Setting @Company With The Details Of Current Company
  def set_company
    @company = Company.find_by_slug(params[:company_id])
  end

  # Never Trust Parameters From the Scary Internet, only Allow the White List Through.
  def album_params
    params.require(:album).permit(:name, :description,:images).merge(user_id: current_user.id , company_id:@company.id)
  end
end