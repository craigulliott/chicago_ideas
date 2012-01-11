class Application::SpeakersController < ApplicationController
  
  # Speakers landing page
  def index
    # @featured = User.find_all_by_speaker(1);    # we need to get featured speakers
    @speakers = User.find_all_by_speaker(1) # only grab the users flagged as speakers
  end
  
  # show and individual speaker
  def show
    if params[:id].is_number? # check if an ID or permalink is passed
      @speaker = User.find(params[:id])
    else
      @speaker = User.find_by_permalink(params[:id])
    end
    
  end
  
  
  # Filter speakers
  def filter
    @speakers = User.find(params[:filter])
  end
  
end
