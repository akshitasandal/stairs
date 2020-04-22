=begin
  Namespace : Admin
  Controller: AlbumsController
  Created By: Zafar
  Description: Controller dedicated to CRUD displayed in admin section for companies
=end
class Admin::AlbumsController < Admin::AdminController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :set_company
  before_action :pundit_authorize
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => :show

  def pundit_authorize
    authorize [:admin, @album||:album]
  end

  # GET /albums
  # GET /albums.json
  def index
    @albums =  @company.albums.where(:deleted => 0)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @images = @album.images
    @data = {:type => "album_view",  :object_id => @album.id , :ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
  end

  # GET /albums/new
  def new
    @album = Album.new(:company_id => @company.id)
  end

  # GET /albums/1/edit
  def edit
    @images = @album.images
  end

  # POST /albums
  # POST /albums.json
  def create
    @company =  Company.find_by_slug(params[:company_id])
    @album =  Album.new(album_params)
    respond_to do |format|
      if @album.save
        images = params[:album][:images]
        if images.present?
          images.each do |image|
            @album.images.create(:image => image, :user_id => current_user.id)
          end
        end
        format.html { redirect_to admin_company_album_url(@company, @album), notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        images = params[:album][:images]
        if images.present?
          images.each do |image|
            @album.images.create(:image => image, :user_id => current_user.id)
          end
        end
        format.html { redirect_to admin_company_album_url(@company, @album), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :back }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.JSON
  def destroy
    @album.update(deleted: '1')
    respond_to do |format|
      format.html { redirect_to admin_company_albums_path(@company), notice: 'Album was successfully destroyed.' }
      format.json { render :back, status: :ok, location: @album }
      format.json { head :no_content }
    end
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
