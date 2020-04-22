class UsersController < ApplicationController
  # before_action :authenticate_user!, :except => [:show]
  # before_action :set_user, only: [:show]
  # skip_before_action :authenticate_user!, only: [:validate_useremail]

  #GET /users
  #show detail of all users
  # is_super_admin? use to check user is super admin or not
  def index
    @company = Company.find_by_slug(params[:company_id])
    @user = User.find_by(:id => @company.user_id)
    @users = User.where.not(:role_id => 1).where(:company_id => @company.id).where(:status => 1)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      end
    end
  end

  #GET /users/:id
  #show a particular user detail
  def show
    @user = User.find_by_username( params[:id] )
    @data = {:type => "profile_view", :object_id => @user.id, :ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
    @company_count = @user.company
    if current_user.present?
      @blog_posts = @user.blog_posts
      @follow_status = UserFollower.where( :user_id => @user.id, :follow_user_id => current_user.id, :followed => 1).count
      @followed = CompanyFollower.followed_companies(@user.id,params)
    else
      @blog_posts = @user.blog_posts.where(:private => "0")
    end
    @followers =  UserFollower.where(:user_id => @user.id, followed: 1).count
    @following =  UserFollower.where(:follow_user_id => @user.id, followed: 1).count
    render layout: "homepage"
  end

  #GET /users/:id/edit
  #Edit a particular user
  def edit

  end

  #check email is exist
  def validate_useremail
    email = params[:user][:email]
    email_flag = User.where(:email => email).count
    status = (email_flag > 0) ? false : true
    render json: {:status => status}
  end

  # user identification
  def set_user
    @user = User.find_by_username( params[:id] )
  end

  # DELETE /users/1
  def destroy
    @user = User.find_by_username(params[:id])
    @user.update(id: @user.id, status: '0')
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

   # function to follow a user
  def follow
    @data = {:user_id => params[:follow_user_id], :follow_user_id => current_user.id, :followed => 1}
    status = UserFollower.follow(@data)
    render json: {:status => status}
  end
  
  # function to un-follow a user
  def unfollow
    @data = {:user_id => params[:follow_user_id] , :follow_user_id => current_user.id}
    status = UserFollower.unfollow(@data)
    render json: {:status => status}    
    # render layout: "homepage"

  end

  private
  # User permitted params
  def user_params
      params.require(:user).permit(:avatar)
  end

end