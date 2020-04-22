class ApplicationController < ActionController::Base
  layout :layout_by_resource  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'will_paginate'
  before_filter :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
    protect_from_forgery
    include ApplicationHelper
    include Pundit
    #before_action  :authorize_action
    # pagination Limit
    WillPaginate.per_page = 10
    helper :application
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    # helper_method :current_user

    #  def authorize_action
    #    files = Dir[Rails.root + 'app/models/*.rb']
    #    models = files.map{ |m| File.basename(m, '.rb').camelize }
    #    model = controller_name.classify
    #    model_exists = models.include? model
    #    if model_exists
    #      authorize model.constantize
    #    end
    #  end
    def after_sign_in_path_for(resource)
      admin_admin_index_path
    end

    private
    #If User not authorized show Error message.
    def user_not_authorized
      redirect_to request.referrer || admin_admin_index_path, notice: "You are not authorized to perform this action."
    end

      def layout_by_resource
      if devise_controller?
        "homepage"
      else
        "application"
      end
  end

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :username , :email, :password) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :username, :bio , :skills, :email, :password , :avatar) }
    end

  end
