class Admin::ImagesController < Admin::AdminController
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

  # GET /images/1/edit
  def edit

  end

  # GET /images/:id
  def update
    #@image = Image.find params[:id]
  end

  # Image identification
  def set_image
    @image = Image.find( params[:id] )
  end

  # DELETE /companies/1
  def destroy
    @image = Image.find (params[:id])
    @image.update(user_id:current_user.id, deleted: '1')
    respond_to do |format|
      format.html { redirect_to :back , notice: 'Image was successfully destroyed.' }
    end
  end
end
