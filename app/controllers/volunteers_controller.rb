class VolunteersController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    if current_user and current_user.volunteer.present?
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.'
    elsif current_user
      @volunteer = current_user.build_volunteer
    else
      redirect_to new_user_registration_path, :notice => 'To apply as a Volunteer, please first create an account or log in.' 
    end
  end
  
  def create
    @volunteer = current_user.build_volunteer(params[:volunteer])
    if @volunteer.save
      redirect_to root_path, :notice => 'Thank you, your application has been recieved.'
    else
      render :new
    end
  end
    
end
