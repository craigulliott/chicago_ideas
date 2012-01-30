class CommunityPartnerApplicationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    @meta_data = {:page_title => "Community Partners", :og_image => "/assets/images/application/logo.png", :og_title => "Community Partners | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.community_partner_application.present?
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.'
    elsif current_user
      @community_partner_application = current_user.build_community_partner_application
    else
      redirect_to new_user_registration_path, :notice => 'To submit your organization, please first create an account or log in.' 
    end
  end
  
  def create
    @meta_data = {:page_title => "Community Partners", :og_image => "/assets/images/application/logo.png", :og_title => "Community Partners | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    @community_partner_application = current_user.build_community_partner_application(params[:community_partner_application])
    if @community_partner_application.save
      redirect_to root_path, :notice => 'Thank you, your application has been recieved.'
    else
      render :new
    end
  end
    
end
