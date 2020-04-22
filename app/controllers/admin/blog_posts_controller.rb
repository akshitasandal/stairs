class Admin::BlogPostsController < Admin::AdminController
  before_action :set_company , only: [:new, :show, :edit, :update, :destroy, :create, :index]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :pundit_authorize , except: [:upload_post_image,:validate_blog_post_slug, :remove_featured_image, :draft_posts]
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => :show

  # check auhorized action
  def pundit_authorize
    unless is_super_admin?
      authorize [:admin, @blog_post || @company.blog_posts.new]
    end
  end
  

  # GET /posts
  # GET /posts.json
  def index
    conditions = {:deleted => 0}
    conditions[:publish] = 1 unless is_super_admin?
    conditions[:company_id] = @company.id if params[:company_id].present?
    conditions[:publish] = params[:publish] if params[:publish].present?
    params[:page] = 1 unless params[:page].present?

    @blog_posts = BlogPost.where(conditions).order('created_at DESC')
    @companies = Company.all
  end

  # GET /posts/new
  def new
    @categories = PostCategory.where(:status => "1").where(:deleted => "0")
    @user = User.where.not(:role_id => 1)
    @companies = Company.all
    if params[:company_id].present?
      @company = Company.find_by_slug(params[:company_id])
      # check_company_access
      @blog_post = BlogPost.new(:company_id => @company.slug)
    else
      @blog_post = BlogPost.new()
    end
  end

  # GET /posts/1
  def show
    @company = Company.find_by_slug(params[:company_id])
    @blog_post = BlogPost.find_by_slug(params[:id])
  end

  # GET /posts/category/category_name
  def show_category_blog_posts
    # @blog_posts =  PostCategory.find_by_name(to_de_param(params[:category_name])).blog_posts.where(:deleted => "0").where(:publish => "1").order('updated_at DESC').paginate(:page => params[:page], :per_page => 5)
    @blog_posts= PostCategory.where("find_in_set(?, post_category_ids)", to_de_param(params[:category_name])).blog_posts.where(:deleted => "0").where(:publish => "1").order('updated_at DESC').paginate(:page => params[:page])
  end

  #GET /posts/tag/tags_name
  def show_tags_blog_posts
    @blog_posts= BlogPost.where("find_in_set(?, tags)", to_de_param(params[:tag_name])).where(:deleted => "0").where(:publish => "1").order('updated_at DESC').paginate(:page => params[:page])
    #@blog_posts= BlogPost.where("tags like ?", "%#{params[:tag_name]}%")
  end

  # GET /posts/1/edit
  def edit
    @companies = Company.all
    @categories = PostCategory.where(:status => "1").where(:deleted => "0")
  end

  # POST /posts
  # POST /posts.json
  def create
    @company = Company.find_by_slug(params[:company_id])
    @blog_post =  BlogPost.new(blog_post_params)
    respond_to do |format|
      if @blog_post.save
       # time = Time.strptime(params[:blog_post][:published_at], '%m/%d/%Y %H:%M')
       # @blog_post.update_attributes(:published_at => time)
        if is_user?
          params[:user_id] = current_user.id
        else
          params[:user_id] = @company.user_id
        end
        params["image_ids"] = params["image_ids"].split(",")
        @blog_post.update_attributes(:user_id => params[:user_id])
        @blog_post_image = BlogPostImage.where(id: params["image_ids"])
        @blog_post_image.update_all(:blog_post_id => @blog_post.id ) if @blog_post_image.present?
        if params[:commit] == "Save and Publish"
          @blog_post.update_attributes(:publish => "1")
        else
          @blog_post.update_attributes(:publish => "0")
        end
        format.html { redirect_to edit_admin_company_blog_post_path(@company, @blog_post), notice: 'Blog was successfully created.' }
      else
        format.html { render :new }
      end
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @blog_post = BlogPost.find_by_slug(params[:id])
    @blog_post.post_category_ids = post_category_params[:post_category_ids]
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        if params[:blog_post][:company_id].present?
          @blog_post.update_attributes(:company_id => params[:blog_post][:company_id])
        end
        params[:user_id] =  is_user? ? current_user.id : @company.user_id
        @blog_post.update_attributes(:user_id => params[:user_id])
        if params[:commit] == "Save and Publish"
          @blog_post.update_attributes(:publish => "1")
        else
          @blog_post.update_attributes(:publish => "0")
        end
        params["image_ids"] = params["image_ids"].split(",")
        @blog_post_image = BlogPostImage.where(id: params["image_ids"])
        @blog_post_image.update_all(:blog_post_id => @blog_post.id ) if @blog_post_image.present?
        format.html { redirect_to edit_admin_company_blog_post_path(@company,@blog_post), notice: 'Blog Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :back }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.JSON
  def destroy
  	@blog_post = BlogPost.find_by_slug(params[:id])
    @blog_post.update(deleted: '1')
    respond_to do |format|
      format.html { redirect_to admin_company_blog_posts_path, notice: 'Blog Post was successfully destroyed.' }
    end
  end

  # function to upload a blog post image in ckeditor
  def upload_post_image
    @image = BlogPostImage.new(:blog_post_image => params[:blog_post_image])
    respond_to do |format|
      if @image.save
        format.js {
          render json: {:img_url => @image.blog_post_image.url(), :med_img_url => @image.blog_post_image.url('medium'), :image_id => @image.id }
        }
      else
        render json: "error"
      end
    end
  end

  #method to remove featured image
  def remove_featured_image
    @blog_post = BlogPost.find_by_slug(params[:id])
      if @blog_post.update_attributes(featured_image: nil)
        render json: {:status => true}
      else
        render json: {:status => false}
      end
  end

  # to show draft posts
  def draft_posts
    @blog_posts = BlogPost.where(:deleted => '0').where(:company_id => current_user.company_id).where(:publish => "0").order('created_at DESC').paginate(:page => params[:page])
  end

  #check company access
  def check_company_access
    if @company.present? && @company.user_id == current_user.id && !is_super_admin?
          redirect_to admin_admin_index_path
    end
  end
  
  def validate_blog_post_slug
    slug_found = BlogPost.where(slug: params[:blog_post][:slug]).count 
    if slug_found > 1
      message = slug_found ? "ERROR" : "SUCCESS"
      render json: {message: message}
    else
      render json: {status: true  }
    end
  end  

private
  # for slug generation
  def to_de_param(str)
    str.split("-").join(" ")
  end

  # blog posts identification
  def set_blog_post
    unless @blog_post = BlogPost.where(slug: params[:id], company_id: @company.id).first
      redirect_to admin_admin_index_path, notice: "Blog post not found"
    end
  end

  # company identification
  def set_company
    @company = Company.find_by_slug(params[:company_id])
    if !is_super_admin? && @company.nil?
      redirect_to admin_admin_index_path, notice: "You don't have a company yet."
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_post_params
  	params.require(:blog_post).permit(:title,:user_id,:private,:visible_to_followers, :published_at, :tags,:description,:body,:keywords,:featured_image,:slug, :publish,:blog_id,:user_id, :post_category_ids => []).merge( :company_id => @company.id)
  end

  # post category permitted params
  def post_category_params
    params.require(:blog_post).permit(:post_category_ids => [] )
  end
end
