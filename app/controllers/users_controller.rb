class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  # the users account homepage
  def index
    @user = current_user
  end
  
  
  def edit
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
  
  
  # Speakers landing page
  def list_speakers
    @speakers = User.find_all_by_speaker(1) # only grab the users flagged as speakers
    render "speakers/index"
  end
  
  # show and individual speaker
  def speaker
    if params[:id].is_number? # check if an ID or permalink is passed
      @speaker = User.find(params[:id])
    else
      @speaker = User.find_by_permalink(params[:id])
    end
    #@speakers = Talk.
  end
  
  
  def list_team_members
    @staff = User.staff
  end  
  
  def team_member
    @staff = User.staff # get all staff members
    @staff_member = User.find(params[:id]) # individual staff item
  end

  
end
