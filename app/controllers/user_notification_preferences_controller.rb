class UserNotificationPreferencesController < ApplicationController
	
	def unsubscribe
	  # user = Rails.application.message_verifier(:unsubscribe).verify(params[:id])
	  @user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
  	UserNotificationPreference.where(:user_id => @user.id , :notification_type_id => "5").update_all(status: "0")
    flash[:notice] = 'Subscription Cancelled' 
    redirect_to root_url
	end


	# private
	#   def user_params
	#     params.require(:user).permit(:subscription)
	#   end

end
