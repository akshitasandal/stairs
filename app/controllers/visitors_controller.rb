class VisitorsController < ApplicationController
  #show homepage content
  def index
    @company = Company.new
    @city = City.all
    @company_size_groups = CompanySizeGroup.all
    @functional_area= FunctionalArea.all
    @recent_add = Company.recent_add
    @most_view = Company.most_view
  end
  
end
