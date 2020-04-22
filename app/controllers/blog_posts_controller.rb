  class BlogPostsController < ApplicationController
  layout "homepage" , :only => [:index, :show, :trending_posts, :all_posts, :show_tags_blog_posts, :show_category_blog_posts]
  before_action :set_blog_posts, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
#  before_action :set_company 
  skip_before_action :authenticate_user!, only: [:all_posts,:visible_to_followers_posts,:show,:search,:index,:show_category_blog_posts,:show_tags_blog_posts, :trending_posts]

  # GET /posts
  # GET /posts.json
  
  def index
    conditions = {:deleted => "0", :private => "0" , :publish => "1"}
    # if params[:search].present?
    #   conditions_post = "title like "  "'%#{params[:search]}%'"
    #   conditions_tags = "find_in_set('#{params[:search]}', tags)"  
    #   @blog_posts = BlogPost.where(conditions_post).where(conditions).order('created_at DESC') 
    #   @tag_posts = BlogPost.where(conditions_tags).where(conditions).order('created_at DESC')
    #   @category_posts = PostCategory.find_by_name(params[:search]).try(:blog_posts)
    #   @companies = Company.where("name like "  "'%#{params[:search]}%'")
    #   @users = User.where("username like "  "'%#{params[:search]}%'")
    #   if current_user.present? && !is_super_admin?
    #     @private_posts = BlogPost.where(:company_id => current_user.company_id,:private => '1').order('created_at DESC')
    #     if @private_posts.present?
    #       cond = {:company_id => current_user.company_id,:deleted => "0", :private => "1" , :publish => "1"}
    #       @private_blog_posts = BlogPost.where(conditions_post).where(cond).order('created_at DESC') 
    #       @private_tag_posts = BlogPost.where(conditions_tags).where(cond).order('created_at DESC')
    #       @private_cat_posts = PostCategory.find_by_name(params[:search])
    #       @private_category_posts = @private_cat_posts.present? && @private_cat_posts.blog_posts.present? ? @private_cat_posts.blog_posts.where(cond).order('created_at DESC') : ""
    #     end
    #   end
    # else
       @blog_posts = BlogPost.all_posts
    # end
    # @private_posts = current_user.present? && !is_super_admin?  ? BlogPost.where(:company_id => current_user.company_id,:private => '1').order('created_at DESC') : ""
    @trending_posts=BlogPost.select("blog_posts.*, count(views.object_id)/DATEDIFF(CURDATE(), blog_posts.created_at) views_count")
                .joins("LEFT JOIN views ON views.object_id = blog_posts.id WHERE blog_posts.deleted = 0 
                AND blog_posts.publish = 1 AND blog_posts.updated_at > DATE_SUB(CURDATE(), INTERVAL 1 WEEK)  
                GROUP BY blog_posts.id ORDER BY views_count DESC")
  end

  def all_posts
    @blog_posts = BlogPost.where(:deleted => "0").paginate(:page => params[:page], :per_page => 6).order('created_at DESC')
    respond_to do |format|
       format.html 
       # format.json {}
       format.js 
    end
    # render layout: "homepage"
  end

  def visible_to_followers_posts
    @post_company_followers =  BlogPost.where(:visible_to_followers => "1")
  end

  # GET /posts/1
  def show
    @blog_posts = []
    @tags = @blog_post.tags.split(",")
    @tags.each do|tag|
      @blog_posts= BlogPost.where("find_in_set(? , tags)", tag).where.not(:id => @blog_post.id)
    end 
    @blog_posts
    @data = {:type => "post_view",  :object_id => @blog_post.id , :ip => request.remote_ip, :user => user_signed_in? ? current_user.id : "" }
    @view = View.track_view(@data)
    @views = View.where(:view_type_id => 5).where(:object_id => @blog_post.id).count
  end

  # GET /posts/category/category_name
  def show_category_blog_posts
    @blog_posts = PostCategory.find_by_name(to_de_param(params[:category_name])).blog_posts.paginate(:page => params[:page], :per_page => 6)
  end
  
  #GET /posts/tag/tags_name
  def show_tags_blog_posts
    @blog_posts= BlogPost.where("find_in_set(?, tags)", to_de_param(params[:tag_name])).where(:deleted => "0").where(:publish => "1").paginate(:page => params[:page], :per_page => 6).order('updated_at DESC')
    # @blog_posts= BlogPost.where("tags like ?", "%#{params[:tag_name]}%")
  end
 
  # to show unpublished posts
  def unpublished_posts
    @blog_posts = BlogPost.where(:deleted => '0').where(:publish => "0").order('created_at DESC')
  end
  
  def trending_posts
    @blog_posts=BlogPost.select("blog_posts.*, count(views.object_id)/DATEDIFF(CURDATE(), blog_posts.created_at) views_count")
                .joins("LEFT JOIN views ON views.object_id = blog_posts.id WHERE blog_posts.deleted = 0 
                AND blog_posts.publish = 1 AND blog_posts.created_at > DATE_SUB(CURDATE(), INTERVAL 1 WEEK)  
                GROUP BY blog_posts.id ORDER BY views_count DESC")
  end

  private
  
  # for slug generation
  def to_de_param(str)
    str.split("-").join(" ") 
  end 

  # blog posts identification
  def set_blog_posts
    if current_user.present? 
      @blog_post = BlogPost.find_by_slug(params[:id])
      # if @blog_post.private == true && current_user.company_id != @blog_post.company_id 
      #   redirect_to root_path
      # end
    else
      @blog_post = BlogPost.find_by_slug(params[:id])
        # if @blog_post.private == true
        #   redirect_to root_path
        # end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_post_params
  	params.require(:blog_post).permit(:title,:tags,:description,:body,:keywords,:featured_image,:post_category_id,:slug, :publish,:blog_id).merge(:company_id => @company.id || current_user.companies[0].id )
  end
end
