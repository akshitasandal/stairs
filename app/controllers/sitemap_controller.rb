class SitemapController < ApplicationController
	def index
    @users = User.where.not(:role_id => "1")
    @posts = BlogPost.all
    @companies = Company.all
    respond_to do |format|
      format.xml
    end
  end
end
