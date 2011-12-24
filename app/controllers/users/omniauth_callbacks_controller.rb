class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # facebook
  # ---------------------------------------------------------------------------
  def facebook
    
    user_data = env["omniauth.auth"]['extra']['raw_info']
    fb_uid = env["omniauth.auth"]["uid"]
    fb_access_token = env["omniauth.auth"]["credentials"]["token"]

    after_connect_goto = session[:after_facebook_connect_path] ? session[:after_facebook_connect_path] : root_path
    
    # if we are currently signed in
    if user_signed_in?

      # add these facebook credentials to this user
      current_user.update_attributes(:fb_uid => fb_uid, :fb_access_token => fb_access_token)
      redirect_to after_connect_goto, :notice => "You successfully linked your account to Facebook"
      return
      
    # we are not signed in, but this facebook user already exists
    elsif user = User.find_by_fb_uid(fb_uid)
      
      # if this user is already connected to this facebook account, then sign_in
      sign_in user
      redirect_to after_connect_goto, :notice => "You have signed in successfully"
      return
      
    # we are not signed in, but this user already exists
    elsif user = User.find_by_email(user_data["email"])
      
      # if this is already connected to a facebook account then fail gracefully
      if user.connected_to_facebook?
        redirect_to root_path, :error => "We're sorry, but the email address #{user_data["email"]} already exists and is connected to Facebook account: #{user.fb_uid}"
        return
      end
      
      # add these facebook credentials to this user
      user.update_attributes(:fb_uid => fb_uid, :fb_access_token => fb_access_token)
      
      # sign the user in
      sign_in user
      redirect_to after_connect_goto, :notice => "You have signed in successfully"
      return

    # its a new user, create a user with a temporary password.
    else 
      user = User.new
      user.email = user_data["email"]
      user.temporary_password = Devise.friendly_token[0,8]
      user.fb_uid = fb_uid
      user.fb_access_token = fb_access_token
      # incase this facebook user has hidden their name with privacy settings
      user.name = user_data['name'] || "User #{fb_uid}"
      user.save!

      sign_in user
      redirect_to after_connect_goto, :notice => "Your account has been created successfully"
      return

    end
    
    redirect_to after_connect_goto, :notice => "Facebook connect failed."
  end
  
  # twitter
  # ---------------------------------------------------------------------------
  def twitter
    
    after_connect_goto = session[:after_twitter_connect_path] ? session[:after_twitter_connect_path] : root_path
    
    twitter_token = env["omniauth.auth"]["credentials"]["token"]
    twitter_secret = env["omniauth.auth"]["credentials"]["secret"]
    
    # we dont use twitter for single sign on
    unless user_signed_in?
      redirect_to after_connect_goto, :notice => "Please sign in before connecting with twitter."
    end
    
    # add these facebook credentials to this user
    current_user.twitter_token = twitter_token
    current_user.twitter_secret = twitter_secret
    current_user.save!
    redirect_to after_connect_goto, :notice => "You successfully linked your account to Twitter"
    
  end
    
end