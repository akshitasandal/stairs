class InvitationsController < Devise::InvitationsController
  layout "admin" , :only => [:new]

  # GET users/invitation/new
  def after_invite_path_for(resource)
    new_user_invitation_path
  end

  private
   # this is called when creating invitation
   # should return an instance of resource class
    def invite_resource
     ## skip sending emails on invite

      super do |u|
        if u.save
          conditions = {}
          conditions[:role_id] = params[:role] if params[:role].present?
          conditions[:role_id] =  "3" if is_super_admin?
          conditions[:company_id] = params[:company_id] if params[:company_id].present?
          conditions[:company_id] = current_user.company.id if current_user.company.present?
          u.update_attributes(conditions)
        end  
      end
    end

   # this is called when accepting invitation
   # should return an instance of resource class
    def accept_resource
      resource = resource_class.accept_invitation!(update_resource_params)
     ## Report accepting invitation to analytics
    #Analytics.report('invite.accept', resource.id)
      resource.accept_invitation!
      resource
    end
end
