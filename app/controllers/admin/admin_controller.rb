=begin
  Namespace : Admin
  Controller: AdminController
  Created By: Zafar
  Description: Controller acts like a base controller for Admin namespace and contains common code
=end
class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  # GET /dashbaord
  def index
  end

end
