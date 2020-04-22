class CompaniesController < ApplicationController
    layout "homepage" , :only => [:index, :show, :view_companies]

  before_action :set_company, only: [:show, :edit, :update, :destroy,:search,:subscribe,:index]
  # before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show,:search,:index]
  # GET /companies
  # GET /companies.json
  #!is_super_admin? use to check user is super admin or not
  def index
    @company = Company.new
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @recent_add = Company.recent_add
    @most_view = Company.most_view
    @blog_post = BlogPost.last(4)
    if params[:orders]
      args = {}
      args[:params] = params.slice(:name,:functional_area_id,:city_id,:company_size_group_id)
      args[:order] = params[:orders]
      args[:page] = params[:page]
      @companies = Company.search_company(args).paginate(:page => params[:page])
    else
      conditions = {:status => 1}
      if params[:own_companies]
       conditions[:user_id] = current_user.id
      end
      @companies =  Company.where(conditions).paginate(:page => params[:page])
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @album = Album.new(:company_id => @company.id)
    @testimonial = Testimonial.new(:company_id => @company.id)
    @testimonials = @company.testimonials
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @city = City.all
    @albums = @company.albums
    @data = {:type => "company_view", :object_id => @company.id ,:ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
    if current_user.present?
      @follow_status = CompanyFollower.where( :user_id => current_user.id, :company_id => @company.id, :followed => 1).count
      @bookmark_status = CompanyFollower.where( :user_id => current_user.id, :company_id => @company.id, :bookmarked=> 1).count
    end
    @company
    user_id = @company.user_id
    @user = User.find_by(id: user_id)
    @users = User.where.not(:role_id => 1).where(:company_id => @company.id).where(:status => 1)
    @company_posts = current_user.present? && current_user.company_id == @company.id ? @company.blog_posts.paginate(:page => params[:page], :per_page => 3) : @company.blog_posts.where(:private => "0").paginate(:page => params[:page], :per_page => 3)
    respond_to do |format|
       format.html 
       # format.json {}
       format.js 
    end
  end

  # function to list all companies
  def view_companies
    @company = Company.new
    @city = City.all
    @functional_area= FunctionalArea.all
    @recent_add = Company.recent_add
    @most_view = Company.most_view
      params["category"] = FunctionalArea.find_by_name(to_de_param(params["category"])).try(:id)
      params["location"] = City.find_by_name(to_de_param(params["location"])).try(:id)
      params["sort"] = "recent_add" || "most_view"
      @companies = Company.search(params)
      respond_to do |format|
       format.html 
       # format.json {}
       format.js 
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

  # function to follow a company
  def subscribe
    @data = { :user_id => current_user.id, :company_id => params[:company_id], :followed => 1}
    status = CompanyFollower.follow(@data)
    render json: {:status => status}
  end
  
  # function to un-follow a company
  def unsubscribe
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
    status = CompanyFollower.unfollow(@data)
    render json: {:status => status} 
  end
  
  #function to bookmark a company 
  def bookmark
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id], :bookmarked => 1}
    status = CompanyFollower.bookmark(@data)
    render json: {:status => status}
  end
  
  #function to upadate bookmark
  def bookmarked
    @data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
    status = CompanyFollower.bookmarked(@data)
    render json: {:status => status}    
  end

  private
  
  # Use callback to share common setup or constraints between actions.
  def set_company
    @company = Company.find_by_slug(params[:id])

  end
  
  # parametrizes the string
  def to_de_param(str)
    str.gsub('-', ' ').titleize
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :functional_area_id,:owner_name, :website,:overview,:company_size_group_id,:founded, :latitude, :longitude , :primary_email, :secondary_email, :primary_contact_number, :secondary_contact_number, :contact_person, :city_id, :address,:logo,:cover_photo).merge(user_id: current_user.id)
  end

end
