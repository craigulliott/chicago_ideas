class Application::SpeakersController < ApplicationController
  
  # Speakers landing page
  def index
    # @featured = User.find_all_by_speaker(1);    # we need to get featured speakers
    @speakers = User.find_all_by_speaker(1) # only grab the users flagged as speakers
  end
  
  # show and individual speaker
  def show
    @speaker = User.find(params[:id])
  end
  
  # Filter speakers
  def filter
    @speakers = User.find(params[:filter])
  end
  
end
