class PostCategoriesController < ApplicationController
  before_action :set_post_category, only: [:show, :edit, :update, :destroy]
  # before_action :set_blog_post
  # GET /post_categories
  # GET /post_categories.json
  def index
    @post_categories = PostCategory.where(:deleted => '0').order('updated_at DESC')
  end

  def show
    if current_user.present? && @post_category.user.try(:company_id) == current_user.company_id
      @blog_posts = PostCategory.find_by_name(to_de_param(params[:id])).blog_posts.paginate(:page => params[:page], :per_page => 6)
    else
      @blog_posts = PostCategory.find_by_name(to_de_param(params[:id])).blog_posts.where(:private => "0").paginate(:page => params[:page], :per_page => 6)
    end
    render layout: "homepage"
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
    params.require(:post_category).permit(:name,:status)
  end
end
