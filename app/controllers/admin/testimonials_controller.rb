class Admin::TestimonialsController < Admin::AdminController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
  before_action :set_company
  # before_action :pundit_authorize
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => :show
#  before_filter :require_user # require_user will set the current_user in controllers

  # check auhorized action
  def pundit_authorize
    authorize [:admin, @testimonial||:testimonial]
  end

  # GET /testimonials
  # GET /testimonials.json
  def index
    @testimonials = @company.testimonials.where(:deleted => '0')
  end

  # GET /testimonials/1
  # GET /testimonials/1.json
  def show

  end

  # GET /testimonials/new
  def new
    @testimonial = Testimonial.new(:company_id => @company.id)

  end

  # GET /testimonials/1/edit
  def edit

  end

  # POST /testimonials
  # POST /testimonials.json
  def create
    @testimonial = Testimonial.new(testimonial_params)
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to admin_company_testimonial_url(@company, @testimonial), notice: 'Testimonial was successfully created.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testimonials/1
  # PATCH/PUT /testimonials/1.json
  def update
    respond_to do |format|
      if @testimonial.update(testimonial_params)

        format.html { redirect_to admin_company_testimonial_url(@company, @testimonial), notice: 'Testimonial was successfully updated.' }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testimonials/1
  # DELETE /testimonials/1.json
  def destroy
    conditions = {:id => @testimonial.id}
    if !is_super_admin?
      conditions[:company_id] = @company.id
    end
    @data = Testimonial.where(conditions).update_all(:deleted => 1)
    respond_to do |format|
      format.html { redirect_to admin_company_testimonials_path(@company), notice: 'Testimonial was successfully destroyed.' }
      format.json { head :no_content }
    end
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
