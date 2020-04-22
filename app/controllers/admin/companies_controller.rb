=begin
  Namespace : Admin
  Controller: CompaniesController
  Created By: Zafar
  Description: Controller dedicated to CRUD displayed in admin section for companies
=end
class Admin::CompaniesController < Admin::AdminController
  before_action :set_company, only: [:show, :edit, :update, :destroy,:search,:follow,:index]
  before_action :authenticate_user!
  before_action :pundit_authorize , except: [:validate_user , :user_invitation]
  skip_before_action :authenticate_user!, :only => :show

  # check auhorized action
  def pundit_authorize
    authorize [:admin, @company||:company]
  end

  # GET /companies
  # GET /companies.json
  #!is_super_admin? use to check user is super admin or not
  def index
    @company = Company.new
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    if is_super_admin?
      @companies = Company.where(:status => 1)
    elsif is_admin?
      @companies = Company.where(:user_id => current_user.id)
    else
      @companies = Company.where(:id => current_user.company_id).where(:status => 1)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find_by_slug(params[:id])
    @album = Album.new(:company_id => @company.id)
    @testimonial = Testimonial.new(:company_id => @company.id)
    @testimonials = @company.testimonials
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @city = City.all
    @albums = @company.albums
    @data = {:type => "company_view", :object_id => @company.id ,:ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
    if user_signed_in?
      @follow_status = CompanyFollower.where( :user_id => current_user.id, :company_id => @company.id, :followed => 1).count
      @bookmark_status = CompanyFollower.where( :user_id => current_user.id, :company_id => @company.id, :bookmarked=> 1).count
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /companies/new
  #!is_super_admin? use to check user is super admin or not
  def new
    @user = User.where.not(:role_id => 1).where(company_id: nil)
    @city = City.all
    @company =  Company.new
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
  end

  # GET /companies/1/edit
  def edit
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @user = User.where.not(:role_id => 1)
  end

  # POST /companies
  # POST /companies.json
  def create
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @company = Company.new(company_params)
     respond_to do |format|
      if @company.save
        if is_admin? && current_user.company == nil
          current_user.update_attributes(:company_id => @company.id)
        end
        if params[:company][:user_id].present?
          @company.update_attributes(:user_id => params[:company][:user_id] )
          @user = User.find_by(id: params[:company][:user_id])
          if @user.present?
            @user.update_attributes(:company_id => @company.id)
            if @user.role_id != "3"
              @user.update_attributes(:role_id => "3")
            end
          else
            @user = User.create(:email => params[:company][:user_id])
            @user.invite!
          end

          format.html { redirect_to edit_admin_company_path(@company), notice: 'Company was successfully created.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { redirect_to edit_admin_company_path(@company), notice: 'Company was successfully created.' }
          format.json { render :show, status: :created, location: @company }
        end
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    respond_to do |format|
      if @company.update(company_params)
        if is_admin? && current_user.company == nil
          current_user.update_attributes(:company_id => @company.id)
        end
        if params[:company][:user_id].present?
          @company.update_attributes(:user_id => params[:company][:user_id])
          @user = User.find_by(id: params[:company][:user_id])
          user= @user.role_id.split(",")
          if !user.include?("3")
            user << "3"
          end
          @user.update_attributes({:company_id => @company.id,:role_id => user.join(",")})
          format.html { redirect_to edit_admin_company_path(@company), notice: 'Company was successfully updated.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { redirect_to edit_admin_company_path(@company), notice: 'Company was successfully updated.' }
          format.json { render :show, status: :created, location: @company }
        end
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.update(status: '0')
    respond_to do |format|
      format.html { redirect_to admin_companies_path, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Validation on Slug
  def validate_slug
    website = params[:company][:website]
    slug = strip_url(website).split(".").first
    slug_flag = Company.where(:slug => slug).count
    status = (slug_flag > 0) ? false : true
    render json: {:status => status}
  end

   #Validation on User
  def validate_user
    user = params[:company][:user_id]
    user_count = Company.where(:user_id => user).count
    status = (user_count > 0) ? false : true
    render json: {:status => status}
  end


  # function to follow a company
  def follow
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id], :followed => 1}
    status = CompanyFollower.follow(@data)
    status = status ? true :false
    render json: {:status => status}
  end

  # function to un-follow a company
  def unfollow
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
    status = CompanyFollower.unfollow(@data)
    status = status ? true :false
    render json: {:status => status}
  end

  #function to bookmark a company
  def bookmark
     @data = {:user_id =>  current_user.id, :company_id => params[:company_id], :bookmarked => 1}
    status = CompanyFollower.bookmark(@data)
    status = status ? true :false
    render json: {:status => status}
  end

  #function to upadate bookmark
  def bookmarked
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
    status = CompanyFollower.bookmarked(@data)
    status = status ? true :false
    render json: {:status => status}
  end

  private
  # Use callback to share common setup or constraints between actions.
  def set_company
    @company = Company.find_by_slug(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :functional_area_id,:user_id,:owner_name, :website,:overview,:company_size_group_id,:founded, :latitude, :longitude , :primary_email, :secondary_email, :primary_contact_number, :secondary_contact_number, :contact_person, :city_id, :address,:logo,:cover_photo).merge(user_id: current_user.id)
  end

end
