require "rails_helper"

describe 'Routes Spec', type: :routing do
	
	# admin namespace dashboard routes 
	describe 'Admin Section' do
	  	describe 'Users Controller' do
			it "routes /dashboard/users to the users controller" do
				expect(get: "/dashboard/users").to route_to(:controller => "admin/users", :action => "index")
				expect(get: "/dashboard/users/new").to route_to(:controller => "admin/users", :action => "new")
				expect(get: "/dashboard/users/abc/edit").to route_to(:controller => "admin/users", :action => "edit" , :id => "abc")
				expect(post: "/dashboard/users").to route_to(:controller => "admin/users", :action => "create" )
				expect(put: "/dashboard/users/abc").to route_to(:controller => "admin/users", :action => "update", :id => "abc" )
				expect(delete: "/dashboard/users/abc").to route_to(:controller => "admin/users", :action => "destroy" , :id => "abc")
			end
		end
		describe 'Companies Controller' do
			it "routes /dashboard/companies to the companies controller" do
				expect(get: "/dashboard/companies").to route_to(:controller => "admin/companies", :action => "index")
				expect(get: "/dashboard/companies/new").to route_to(:controller => "admin/companies", :action => "new")
				expect(get: "/dashboard/companies/abc/edit").to route_to(:controller => "admin/companies", :action => "edit", :id => "abc")
				expect(post: "/dashboard/companies").to route_to(:controller => "admin/companies", :action => "create")
				expect(put: "/dashboard/companies/abc").to route_to(:controller => "admin/companies", :action => "update", :id => "abc")
				expect(delete: "/dashboard/companies/abc").to route_to(:controller => "admin/companies", :action => "destroy", :id => "abc")
			end
		end
		describe 'BlogPosts Controller' do
			it "routes /dashboard/companies/abc/posts to the blog_posts controller" do
				expect(get: "/dashboard/companies/abc/posts").to route_to(:controller => "admin/blog_posts", :action => "index" , :company_id => "abc")
				expect(get: "/dashboard/companies/abc/posts/new").to route_to(:controller => "admin/blog_posts", :action => "new", :company_id => "abc")
				expect(get: "/dashboard/companies/abc/posts/xyz/edit").to route_to(:controller => "admin/blog_posts", :action => "edit", :company_id => "abc", :id => "xyz")
				expect(post: "/dashboard/companies/abc/posts").to route_to(:controller => "admin/blog_posts", :action => "create" ,:company_id => "abc")
				expect(put: "/dashboard/companies/abc/posts/xyz").to route_to(:controller => "admin/blog_posts", :action => "update",:company_id => "abc", :id => "xyz")
				expect(delete: "/dashboard/companies/abc/posts/xyz").to route_to(:controller => "admin/blog_posts", :action => "destroy", :company_id => "abc", :id => "xyz")
			end
		end
		describe 'PostCategories Controller' do
			it "routes /dashboard/post/categories to the post_categories controller" do
				expect(get: "/dashboard/post/categories").to route_to(:controller => "admin/post_categories", :action => "index")
				expect(get: "/dashboard/post/categories/new").to route_to(:controller => "admin/post_categories", :action => "new")
				expect(get: "/dashboard/post/categories/abc/edit").to route_to(:controller => "admin/post_categories", :action => "edit", :id => "abc")
				expect(post: "/dashboard/post/categories").to route_to(:controller => "admin/post_categories", :action => "create")
				expect(put: "/dashboard/post/categories/abc").to route_to(:controller => "admin/post_categories", :action => "update", :id => "abc")
				expect(delete: "/dashboard/post/categories/abc").to route_to(:controller => "admin/post_categories", :action => "destroy", :id => "abc")
			end
		end
		describe 'Albums Controller' do
			it "routes /dashboard/companies/xyz/albums to the albums controller" do
				expect(get: "/dashboard/companies/xyz/albums").to route_to(:controller => "admin/albums", :action => "index" , :company_id => "xyz")
				expect(get: "/dashboard/companies/xyz/albums/new").to route_to(:controller => "admin/albums", :action => "new", :company_id => "xyz")
				expect(get: "/dashboard/companies/xyz/albums/abc/edit").to route_to(:controller => "admin/albums", :action => "edit", :id => "abc", :company_id => "xyz")
				expect(post: "/dashboard/companies/xyz/albums").to route_to(:controller => "admin/albums", :action => "create", :company_id => "xyz")
				expect(put: "/dashboard/companies/xyz/albums/abc").to route_to(:controller => "admin/albums", :action => "update", :id => "abc", :company_id => "xyz")
				expect(delete: "/dashboard/companies/xyz/albums/abc").to route_to(:controller => "admin/albums", :action => "destroy", :id => "abc", :company_id => "xyz")
			end
		end
		describe 'Testimonials Controller' do
			it "routes /dashboard/companies/xyz/testimonials to the albums controller" do
				expect(get: "/dashboard/companies/xyz/testimonials").to route_to(:controller => "admin/testimonials", :action => "index" , :company_id => "xyz")
				expect(get: "/dashboard/companies/xyz/testimonials/new").to route_to(:controller => "admin/testimonials", :action => "new", :company_id => "xyz")
				expect(get: "/dashboard/companies/xyz/testimonials/abc/edit").to route_to(:controller => "admin/testimonials", :action => "edit", :id => "abc", :company_id => "xyz")
				expect(post: "/dashboard/companies/xyz/testimonials").to route_to(:controller => "admin/testimonials", :action => "create", :company_id => "xyz")
				expect(put: "/dashboard/companies/xyz/testimonials/abc").to route_to(:controller => "admin/testimonials", :action => "update", :id => "abc", :company_id => "xyz")
				expect(delete: "/dashboard/companies/xyz/testimonials/abc").to route_to(:controller => "admin/testimonials", :action => "destroy", :id => "abc", :company_id => "xyz")
			end
		end
	end
	
	# front-end routing
	describe 'non admin Section' do
		describe 'Users Controller' do
			it "routes /abc/users to the users controller" do
				expect(get: "/abc/users").to route_to(:controller => "users", :action => "index" , :company_id => "abc")
				expect(post: "/abc/follow").to route_to(:controller => "users", :action => "follow",:company_id => "abc")
				expect(patch: "/abc/unfollow").to route_to(:controller => "users", :action => "unfollow" , :company_id => "abc")
				expect(get: "/abc/xyz").to route_to(:controller => "users", :action => "show" , :company_id => "abc" , :id => "xyz" )
			end
		end
		describe 'companies Controller' do
			it "routes /companies to the companies controller" do
				expect(post: "/validate_slug").to route_to(:controller => "companies", :action => "validate_slug" )
				expect(post: "/companies/subscribe").to route_to(:controller => "companies", :action => "subscribe")
				expect(patch: "/companies/unsubscribe").to route_to(:controller => "companies", :action => "unsubscribe" )
				expect(post: "/companies/bookmark").to route_to(:controller => "companies", :action => "bookmark" )
				expect(patch: "/companies/bookmarked").to route_to(:controller => "companies", :action => "bookmarked" )
				expect(post: "/validate_user").to route_to(:controller => "companies", :action => "validate_user" )
				expect(get: "/view").to route_to(:controller => "companies", :action => "view_companies" )
				expect(get: "/view/games-in-mohali").to route_to(:controller => "companies", :action => "view_companies" , :category => "games", :location => "mohali")
				expect(post: "/companies").to route_to(:controller => "companies", :action => "create" )
				expect(get: "/companies").to route_to(:controller => "companies", :action => "index" )
				expect(get: "/abc").to route_to(:controller => "companies", :action => "show" , :id => "abc" )
			end
		end
		
		describe 'blog_posts Controller' do
			it "routes /posts to the blog_posts controller" do
				expect(get: "/posts").to route_to(:controller => "blog_posts", :action => "index" )
				expect(get: "/unpublished_posts").to route_to(:controller => "blog_posts", :action => "unpublished_posts" )
				expect(get: "/abc/xyz/posts").to route_to(:controller => "blog_posts", :action => "company_posts" , :company_id => "abc", :user_id => "xyz")
				expect(get: "/abc/tag/google").to route_to(:controller => "blog_posts", :action => "show_tags_blog_posts", :company_id => "abc", :tag_name => "google" )
				expect(get: "/abc/category/games").to route_to(:controller => "blog_posts", :action => "show_category_blog_posts", :company_id => "abc"  ,:category_name => "games")
				expect(get: "/abc/xyz/first").to route_to(:controller => "blog_posts", :action => "show" ,:user_id => "xyz", :company_id => "abc" , :id => "first" )
				expect(get: "/").to route_to(:controller => "blog_posts", :action => "index" )
			end
		end

		describe 'PostCategories Controller' do
			it "routes /categories to the post_categories controller" do
				expect(get: "/categories").to route_to(:controller => "post_categories", :action => "index" )
				expect(get: "/categories/1").to route_to(:controller => "post_categories", :action => "show" , :id => "1")
			end
		end
	end
end