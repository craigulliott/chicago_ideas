class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  # the users account homepage
  def index
    @user = current_user
  end
  
  # remove the current users stored facebook credentials and redirect back to the page they came from 
  def disconnect_facebook
    current_user.fb_uid = nil
    current_user.fb_access_token = nil
    current_user.save!
    redirect_to request.referer, notice: 'Disconnected from Facebook'
  end
  
  # remove the current users stored twitter credentials and redirect back to the page they came from 
  def disconnect_twitter
    current_user.twitter_token = nil
    current_user.twitter_secret = nil
    current_user.save!
    redirect_to request.referer, notice: 'Disconnected from Twitter'
  end
  
end
