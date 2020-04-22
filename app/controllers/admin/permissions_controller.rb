class Admin::PermissionsController < Admin::AdminController
  
  def index
  	# ApplicationController.descendants.each do|cont|
  	# cont.action_methods
  	@role= Role.where.not(:id => 1)
  end
end
