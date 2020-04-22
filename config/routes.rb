Rails.application.routes.draw do
  namespace :admin do
    get 'settings/unsubscribe'
    patch 'settings/update'
  end

  root to: 'blog_posts#index'
  devise_for :users , :controllers => { :omniauth_callbacks => "omniauth_callbacks" , :invitations => "invitations" }, :skip => [:registration]
  devise_scope :user do
    # using login path for registration
    get '/users/cancel' => 'registrations#cancel', :as => :cancel_user_registration
    get '/users/edit' => 'registrations#edit', :as => :edit_user_registration
    put '/users' => 'registrations#update' 
    patch '/users' => 'registrations#update' 
    delete '/users' => 'registrations#destroy'
  end
  get 'sitemap.xml' => 'sitemap#index', defaults: { format: 'xml' }
  resources :images
  resources :post_categories, :path => 'categories',  only:[:index, :show]
  resources :user_notification_preferences , :path => 'user/preferences' do
      collection do 
        get 'unsubscribe'
        patch 'update'

      end
  end
  # resources :users do
  #   collection do
  #     post :follow, :to => "users#follow", :as => 'users/follow'
  #     patch :unfollow, :to => "users#unfollow", :as => 'users/unfollow'
  #   end
  # end
  as :user do
    post :validate_useremail , :to => "users#validate_useremail", :as => 'validate_useremail'
  end

  # Routes for admin dashboard starts here
  namespace :admin, :path => "/dashboard" do
    get 'companies/posts',:to => "blog_posts#index"
    post 'companies/posts',:to => "blog_posts#index"
    post :unfollow_company, :to => "users#unfollow_company" , :as => '/unfollow_company'
    post :unfollow_user , :to => "users#unfollow_user" , :as => '/unfollow_user'
    post :remove_bookmark, :to => "users#remove_bookmark", :as => '/remove_bookmark'
    post "validate_blog_post_slug" => "blog_posts#validate_blog_post_slug"
    # post '/user' , :to => "users#index"
    get "/remove_featured_image/:id" => "blog_posts#remove_featured_image"
    resources :user_notification_preferences , :path => 'user/preferences' do 
      collection do 
        get 'edit_multiple'
        patch 'update'

      end
    end
    resources :users do
      post 'admin/users' , :to => "blog_post#index"
      collection do
        get :followed_companies, :to => "users#followed_companies", :as => '/folllowed_companies'
        get :bookmarked_companies, :to => "users#bookmarked_companies", :as => '/bookmarked_companies'
        get :followed_users, :to => "users#followed_users", :as => '/followed_users'
        get :newsletter_enable_status, :to => "users#newsletter_enable_status", :as => "/newsletter_enable_status"
        patch :update_newsletter_status, :to => "users#update_newsletter_status"
      end
    end
    resources :newsletters
        get '/newsletter/unsubscribe', :to => "newsletters#unsubscribe" , :as => "unsubscribe"
        # post :unsubscribe, :to => "newsletters#unsubscribe"
    resources :roles do
      collection do
        get "role" => "roles#show_roles"
        post 'roles/assign'
      end
    end
    resources :admin, :path => '', only:[:index]
      resources :companies, :path => "companies" ,except:[:show] do
      
        collection do
          post :validate_user, :to => "companies#validate_user", :as => 'validate_user'
        end
        resources :albums
        resources :testimonials
        resources :blog_posts, :path => '/posts', except:[:show]  do
          collection do
            post "upload_post_image" => "blog_posts#upload_post_image"
            get 'drafts'   => "blog_posts#draft_posts"
            get 'tag/:tag_name' => "blog_posts#show_tags_blog_posts", :as => "tag"
            get 'category/:category_name' => "blog_posts#show_category_blog_posts", :as => "category"
          end
      end
    end
    resources :images
    resources :post_categories , :path => '/post/categories',  except:[:show]
  end
  # Routes for admget 'users', :to => 'users#index' , :as => 'users'in dashboard ends here
  
  # routes for Companies, omitting path (controller name)
  resources :companies , :path => "" ,only:[:show,:index] do
    collection do
      post :validate_slug , :to => "companies#validate_slug", :as => 'validate_slug'
      post "/companies/subscribe", :to => "companies#subscribe", :as => 'subscribe'
      patch "/companies/unsubscribe", :to => "companies#unsubscribe", :as => 'unsubscribe'
      post "/companies/bookmark", :to => "companies#bookmark", :as => 'bookmark'
      post :validate_user, :to => "companies#validate_user", :as => 'validate_user'
      patch "/companies/bookmarked", :to => "companies#bookmarked", :as => 'bookmarked'
      get :view, :to => "companies#view_companies", :as => 'view'
      get "view/:category-in-:location", :to => "companies#view_companies" , :as => 'company_location'
      post "/companies" => "companies#create"
      get "/companies" => "companies#index"
      post "/companies" => "companies#index"
      get 'posts',:to => "blog_posts#index"
      post 'posts', :to => "blog_posts#index"
      get 'unpublished_posts',to: "blog_posts#unpublished_posts"
      get 'visible_to_followers_posts', to: "blog_posts#visible_to_followers_posts"
      get 'all-posts', to: "blog_posts#all_posts"
      get 'trending-featured-posts', to: 'blog_posts#trending_posts'
      # get "/remove_featured_image/:id" => "blog_posts#remove_featured_image"
    end
      get 'users', :to => 'users#index' , :as => 'users'
      post 'users', :to => 'users#index' 
    resources :users , :path => "" , only:[:show] do
      collection do
        # get ':id',  controller: "users", action: "show" , :as => "user"
        post :follow, :to => "users#follow", :as => 'users/follow'
        patch :unfollow, :to => "users#unfollow", :as => 'users/unfollow'
      end
    end
    # Nested collection route for companies
    resources :albums, only:[:show]

    resources :testimonials, only:[:show]
  end
  resources :blog_posts, :path => '', only:[:index]  do
    collection do
      get ':company_id/tag/:tag_name',to: "blog_posts#show_tags_blog_posts", :as => "tag_name"
      get ':company_id/category/:category_name', to: "blog_posts#show_category_blog_posts", :as => "category_name"
      get ':company_id/:user_id/:id',  controller: "blog_posts", action: "show" , :as => "blog_post"
    end  
  end
end
