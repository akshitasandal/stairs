class Admin::RolesController < Admin::AdminController
  before_action :authenticate_user!
  before_action :pundit_authorize

  # check auhorized action
  def pundit_authorize
    authorize [:admin, @role ||:role]
  end

  # GET dashboard/roles
  def index
		@user= User.where.not(:role_id => 1)
		@role = Role.where.not(:id=>1)
  end

  # GET dashboard/roles/role
  def show_roles
  	@role = Role.where.not(:id=>1)
  end

  # POST /dashboard/roles/roles/assign
  def assign
  	@user= User.find_by(id: params[:user_id])
    if @user.present?
    	params[:role_id]= params[:role_id].join(",")
    	@user.update_attributes(:role_id => params[:role_id])
      flash[:notice] = "User role has been changed by super admin.!"
    end
    redirect_to admin_roles_path
  end

  # GET /dashboard/roles/:id
  def show
    @user_id = User.find(params[:id]).role_id.split(",")
    respond_to do |format|
      if @user_id.present?
        format.json{
          render json: {role_id: @user_id}
        }
      else
        render json: "error"
      end
    end
  end
end
