class VolunteersController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    redirect_to new_user_registration_path, :notice => 'To apply as a Volunteer, please first create an account on our website.' unless current_user
    @volunteer = current_user.build_volunteer
  end
  
  def create
    @volunteer = current_user.build_volunteer(params[:volunteer])
    if @volunteer.save
      redirect_to root_path, :notice => 'Thank you, your application has been recieved.'
    else
      action :new
    end
  end
    
end
