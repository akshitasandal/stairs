class Admin::UsersController < Admin::AdminController
  	# GET /dashboard/users
  	
  	def index
  		conditions = {:status => 1}
    	@company = Company.find_by_slug(params[:company_id])
    	#if company specific posts are queried
		if params[:company_id].present?
      		conditions[:company_id] = @company.id
    	end
	    if !params[:page].present?
	      params[:page] = 1
	    end
	    @companies = Company.all
	    @roles = Role.where.not(:id => 1)
	    @users = User.where.not(:role_id => 1).where(conditions)
	    if params[:role].present?
    		@users = @users.where("find_in_set(?, role_id)", params[:role])
    	end
    	if is_super_admin?
	    	@users = @users.order('created_at DESC')
	    else
	    	@users = User.where(:company_id => current_user.company_id).where.not(:role_id => 1)
	    end
	   #  debugger
	   #  @users.each do |user|
  		# 	WeeklyNewsletter.weekly_popular_posts(user).deliver
  		# end
  	end

  	def followed_companies
    	@followed = CompanyFollower.followed_companies(current_user.id,params)
  	end

  	def bookmarked_companies
  		@bookmarked = CompanyFollower.bookmarked_companies(current_user.id,params)
  	end

  	def followed_users
  		@followed_users = UserFollower.followed_users(current_user.id, params)
  	end

  	def unfollow_company
  		@data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
		status = CompanyFollower.unfollow(@data)
		render json: {:status => status}    
	end

	def remove_bookmark
		@data = {:user_id =>  current_user.id, :company_id => params[:company_id]}
	    status = CompanyFollower.bookmarked(@data)
	    render json: {:status => status}   
	end
	
	def unfollow_user
		@data = {:user_id => params[:follow_user_id] , :follow_user_id =>  current_user.id}
    status = UserFollower.unfollow(@data)
    render json: {:status => status} 
	end

	def user_roles
		@user = User.find(params[:id]).role_id
		@user = @user.split(",")
		render json: {role_id: @user}
	end
  	# GET dashboard/users/new
	def new
  	@user = User.new()
  	@companies = Company.all
  end

  	# POST dashboard/users
	def create
  	@user = User.new(user_params)
      if @user.save
      	# WeeklyNewsletter.weekly_popular_posts(@user).deliver
			if !is_super_admin?
				@user.update_attributes(:company_id => current_user.company_id)
			elsif is_super_admin? && params[:user][:company_id].present?
				@user.update_attributes(:company_id => params[:user][:company_id])
			end			
      	redirect_to admin_users_path, notice: 'User was successfully created.' 
    	end
	end

	# GET dashboard/users/:id/edit
	def edit
		@user= User.find_by_username(params[:id])
		@role_id = @user.role_id.split(",").map{|r| r.to_i}
		@companies = Company.all
		if is_super_admin?
			@role = Role.where.not(:id => "1")
		elsif is_admin?
			@role = Role.where.not(:id => ["1", "3"])
		end
	end

	# PUT/PATCH dashboard/users/:id
	def update
		if is_super_admin? && params["/dashboard/users/update_newsletter_status"].present?
			status = params["/dashboard/users/update_newsletter_status"]["newsletter_enable_status"]
			User.find_by(:role_id => 1).update_attributes(:newsletter_enable_status => status)
			redirect_to  newsletter_enable_status_admin_users_path
		else
			@user= User.find_by_username(params[:id])
			respond_to do |format|
				if !params[:user][:password].present? && !params[:user][:password_confirmation].present?
		      		if @user.update_without_password(user_params)
		      			user_update_passwords
				        format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
				        format.json { render :show, status: :ok, location: @user }
		      		else
				        format.html { redirect_to admin_users_path }
				        format.json { render json: @user.errors, status: :unprocessable_entity }
		      		end
		      	else
		      		if @user.update(user_params)
		      			user_update_passwords
				        format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
				        format.json { render :show, status: :ok, location: @user }
		      		else
				        format.html { redirect_to admin_users_path }
				        format.json { render json: @user.errors, status: :unprocessable_entity }
		      		end
		      	end
	    	end	
	  end
	end


	# DELETE dashboard/users/:id
	def destroy
		@user= User.find_by_username(params[:id])
	    @user.update(status: '0')
		respond_to do |format|
			format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
		end
	end

	def newsletter_enable_status
		@user = User.find_by(:role_id => 1)
	end


  
  	private

  	# user update without password or with password
  	def user_update_passwords
  		if is_super_admin? && params[:user][:company_id].present?
			@user.update_attributes(:company_id => params[:user][:company_id])
		end
		if params[:user][:role_id].present? && params[:user][:role_id].length > 1 
			params[:user][:role_id].shift
			params[:user][:role_id]
			params[:user][:role_id] = params[:user][:role_id].join(",")
    		@user.update_attributes(:role_id => params[:user][:role_id])
		else
			@user.update_attributes(:role_id => "4")
		end
  	end
	# User permitted params
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation , :newsletter_enable_status, :bio, :skills, :avatar, :company_id)
  	end

end
