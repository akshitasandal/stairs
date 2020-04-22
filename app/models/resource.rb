class Resource < ActiveRecord::Base

  def save_controller
  	ApplicationController.descendants.each do|cont|
  	cont.action_methods
  end

  end



end
