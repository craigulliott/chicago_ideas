class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:index, :edit, :disconnect_facebook, :disconnect_twitter]
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:list_speakers, :speaker, :list_team_members, :team_member]
  
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
    @speakers = User.speaker.search_sort_paginate(params)
    Rails.logger.info 'hello'
    render "speakers/index"
  end
  
  # show and individual speaker
  def speaker
    if params[:id].is_number? # check if an ID or permalink is passed
      @speaker = User.find(params[:id])
    else
      @speaker = User.find_by_permalink(params[:id])
    end
    @chapters = @speaker.chapters.all # Get all chapters that the speaker is part of
    render "speakers/show"
  end
  
  def list_team_members
    get_team_members
  end  
  
  def team_member
    get_team_members
    @team_member = User.find(params[:id]) # individual staff item
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
      User.staff.where('id not in (2,1,5,6,3)').all.each do |u|
        @team << u
      end
      @team
    end
end
