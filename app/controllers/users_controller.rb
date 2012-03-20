class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:index, :disconnect_facebook, :disconnect_twitter]
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:list_speakers, :speaker, :list_team_members, :team_member]
  
  # the users account homepage
  def dashboard
    @meta_data = {:page_title => "#{current_user.name}", :og_image => "", :og_title => "#{current_user.name} | Chicago Ideas Week", :og_type => "article", :og_desc => ""}
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
        render_json_response :error, :html => render_to_string('partials/_newsletter_form.html.haml', :layout => false), :notice => user.errors.first.present? ? user.errors.first.join(' ') : 'Could not save, please check email and name are valid.'
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
    @speakers = User.speaker.not_deleted.order('name').search_sort_paginate(params).per(12)
    @meta_data = {:page_title => "Speakers", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Speakers | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    render "speakers/index"
  end
  
  # show andindividual speaker
  def speaker
    if params[:id].is_number? # check if an ID or permalink is passed
      @speaker = User.find(params[:id])
    else
      @speaker = User.find_by_permalink(params[:id])
    end
    # Get all chapters that the speaker is part of
    @chapters = @speaker.chapters.all
    @meta_data = {:page_title => "#{@speaker.name}", :og_image => "#{@speaker.portrait(:thumb)}", :og_title => "#{@speaker.name} | Chicago Ideas Week", :og_type => "article", :og_desc => "#{@speaker.bio[0..200]}"}
    render "speakers/show"
  end
  
  def list_team_members
    @meta_data = {:page_title => "CIW Team", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "CIW Team | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    get_team_members
  end  
  
  def team_member
    get_team_members
    @team_member = User.find(params[:id])
    @meta_data = {:page_title => "About #{@team_member.name}", :og_image => "#{@team_member.portrait(:thumb)}", :og_title => "About #{@team_member.name} | Chicago Ideas Week", :og_type => "website", :og_desc => "#{@team_member.bio[0..200]}"}
  end

end
