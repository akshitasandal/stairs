module DevisePermittedParameters
  extend ActiveSupport::Concern

#  included do
#    before_action :configure_permitted_parameters
#  end
#
#  protected
#
#  def configure_permitted_parameters
#    devise_parameter_sanitizer.permit(:sign_up, keys: user_params)
#    devise_parameter_sanitizer.permit(:account_update, keys: user_params)
#  end
#
#  def user_params
#    return [:first_name, :last_name, :username, :bio , :skills, :email, :password , :avatar]
#  end

end

DeviseController.send :include, DevisePermittedParameters
