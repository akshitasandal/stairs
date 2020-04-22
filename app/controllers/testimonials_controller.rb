class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
  before_action :set_company
#  before_filter :require_user # require_user will set the current_user in controllers
  # GET /testimonials
  # GET /testimonials.json
  def index
    if is_super_admin? 
      @testimonials = Testimonial.where("deleted = ?", 0).paginate(:page => params[:page])
    else
      @testimonials = Testimonial.where("deleted = ? and company_id = ?", 0, @company.id).paginate(:page => params[:page])
    end
    @testimonial = Testimonial.new(:company_id => @company.id)
    authorize @testimonials
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /testimonials/1
  # GET /testimonials/1.json
  def show
    
  end

  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_testimonial
    @testimonial = Testimonial.find(params[:id]) 
  end

  # Setting @Company With The Details Of current Company
  def set_company
    @company = Company.find_by_slug(params[:company_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def testimonial_params
    params.require(:testimonial).permit(:title, :content).merge(company_id: @company.id)
  end
end
