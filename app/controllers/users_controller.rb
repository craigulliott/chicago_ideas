class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:index, :edit, :disconnect_facebook, :disconnect_twitter]
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:list_speakers, :speaker, :list_team_members, :team_member]
  
  # the users account homepage
  def index
    @page_title = "#{current_user.name} - Your Account"
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def newsletter
    # if a user is signed in, turn on the newsletter flag
    if current_user
      current_user.update_attribute(:newsletter, true)

    # as this is equivilent to subscribing someone to a newsletter, security isnt that importaint.  Just update the flag for existing users too
    elsif existing_user = User.find_by_email(params[:user][:email])
      existing_user.update_attribute(:newsletter, true)
      
    # if a user with this email does not exist, create them with a temporary password and add them as a newsletter subscriber
    else
      user = User.new(
        # hand picking the params to make this secure
        :email => params[:user][:email],
        :name => params[:user][:name],
      )
      user.temporary_password = Devise.friendly_token[0,8]
      # save this new user
      unless user.save
        # send back JSON containing the errors, so we can update the display
        render_json_response :error, :html => render_to_string('partials/newsletter_form.html.haml', :layout => false), :notice => user.errors.to_sentance
        return
      end
    end
    render_json_response :ok, :notice => 'Thank you, You have been added to the CIW newsletter.'
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
    @page_title = "Speakers"
    @speakers = User.speaker.not_deleted.order('name').search_sort_paginate(params)
    render "speakers/index"
  end
  
  # show and individual speaker
  def speaker
    if params[:id].is_number? # check if an ID or permalink is passed
      @speaker = User.find(params[:id])
    else
      @speaker = User.find_by_permalink(params[:id])
    end
    @page_title = "#{@speaker.name}"
    # Get all chapters that the speaker is part of
    @chapters = @speaker.chapters.all
    render "speakers/show"
  end
  
  def list_team_members
    @page_title = "Team Members"
    get_team_members
  end  
  
  def team_member
    get_team_members
    @team_member = User.find(params[:id])
    @page_title = "About #{@team_member.name}"
  end

  private 
    # get all staff members, sorted by priority
    def get_team_members
      # TODO:  add a sort column
      @team = []
      @team << User.find(2)
      @team << User.find(1)
      @team << User.find(5)
      @team << User.find(6)
      @team << User.find(3)
      User.staff.not_deleted.where('id not in (2,1,5,6,3)').all.each do |u|
        @team << u
      end
      @team
    end
end
