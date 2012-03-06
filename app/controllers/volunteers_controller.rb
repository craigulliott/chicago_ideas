class VolunteersController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    @meta_data = {:page_title => "Volunteer for CIW", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Volunteer for CIW | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.volunteer.present?
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.'
    elsif current_user
      @volunteer = current_user.build_volunteer
    else
      redirect_to new_user_registration_path, :notice => 'To apply as a Volunteer, please first create an account or log in.' 
    end
  end
  
  def create
    @meta_data = {:page_title => "Volunteer for CIW", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Volunteer for CIW | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    @volunteer = current_user.build_volunteer(params[:volunteer])
    if @volunteer.save
      VolunteerMailer.send_form(params[:volunteer]).deliver
      #redirect_to root_path, :notice => 'Thank you, your application has been recieved.'
      render 'application/confirmation', :locals => {:title => "Volunteer Application Confirmation", :body => "Thank you for applying to volunteer. We will be in contact shortly.", :url => "#{new_volunteer_application_path}" }
    else
      render :new
    end
  end
    
end
