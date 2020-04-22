class Admin::PostCategoriesController < Admin::AdminController
  before_action :set_post_category, only: [:show, :edit, :update, :destroy]
  before_action :pundit_authorize , except: [:index, :new]

  # before_action :set_blog_post
  
   # check auhorized action
  def pundit_authorize
    authorize [:admin, @post_category || :post_category]
  end
  # GET /post_categories
  # GET /post_categories.json
  def index
    @post_categories = PostCategory.where(:deleted => '0').order('updated_at DESC')
  end

  # GET /post_categories/1
  # GET /post_categories/1.json
  def show
  end

  # GET /post_categories/new
  def new
    @post_category = PostCategory.new
  end

  # GET /post_categories/1/edit
  def edit
  end

  # POST /post_categories
  # POST /post_categories.json
  def create
    @post_category = PostCategory.new(post_category_params)
    respond_to do |format|
      if @post_category.save
        @post_category.update_attributes(:user_id => current_user.id)
        format.html { redirect_to admin_post_categories_path, notice: 'Post category was successfully created.' }
        format.json { render :show, status: :created, location: @post_category }
      else
        @post_category.update_attributes(:user_id => current_user.id)
        format.html { render :new }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_categories/1
  # PATCH/PUT /post_categories/1.json
  def update
    respond_to do |format|
      if @post_category.update(post_category_params)
        if is_user?
          @post_category.update_attributes(:user_id => current_user.id)
        end
        format.html { redirect_to admin_post_categories_path, notice: 'Post category was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_category }
      else
        @post_category.update_attributes(:user_id => current_user.id)
        format.html { render :edit }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_categories/1
  # DELETE /post_categories/1.json
  def destroy
    @post_category.update(deleted: '1')
    respond_to do |format|
      format.html { redirect_to admin_post_categories_url, notice: 'Post category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
       # for slug generation
  def to_de_param(str)
    str.split("-").join(" ") 
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_post_category
      @post_category = PostCategory.find_by_name(to_de_param(params[:id]))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_category_params
      params.require(:post_category).permit(:name,:status ,:user_id)
    end
  end
