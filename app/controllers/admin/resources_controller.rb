class Admin::ResourcesController < Admin::AdminController
  
  def index
  	controllers = Rails.application.routes.routes.map do |route|
  		route.defaults[:controller]
		end.uniq
  end

end
