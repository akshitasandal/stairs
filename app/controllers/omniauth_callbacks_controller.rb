class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  #login with GitHub
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
  
  #login with LinkedIn
  def linkedin
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
  
  #login with Facebook
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
  
  #login with Twitter
  def twitter

    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
  
end
