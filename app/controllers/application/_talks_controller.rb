class Application::TalksController < ApplicationController

  # Talks landing page, get all talks separated by top
  def index
     @talks = TalkBrand.find_by_name("Talk").talks
     @megatalks = TalkBrand.find_by_name("Mega Talk").talks
     @labs = EventBrand.find_by_name("Lab").events
   end
  
  
  def show
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
  end

end
