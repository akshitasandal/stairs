class RegistrationsController < Devise::RegistrationsController
    layout "admin" , :only => [:edit]
  	#edit User without password(Overwrite device Update Method)
  	# def new
  	# 	if true
  	# 	root_path
  	# 	end
  	# end
  	
  	protected
	  	def update_resource(resource, params)
		    if params[:password].blank? && params[:password_confirmation].blank?
		      resource.update_without_password(params)
		    end
		  end
	   	
      # GET /user/:id/edit after updating user
      def after_update_path_for(resource)
	      	edit_user_registration_path
	    end
end