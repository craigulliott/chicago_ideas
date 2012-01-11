class Application::TalksController < ApplicationController

  def index    
    @talks = TalkBrand.find_by_name("Talk").talks
    @megatalks = TalkBrand.find_by_name("Mega Talk").talks
    @edisontalks = TalkBrand.find_by_name("Edison Talk").talks
  end
  
  
  # Talks landing and individual pages
  def talks
    if params[:id].nil? # if no paramter, then load the talks landing
     @talks = TalkBrand.find_by_name("Talk").talks
     render "application/talks/talk_overview"
    else
      @talk = Talk.find(params[:id])
      @chapters = @talk.chapters.all
      render "application/talks/talk_individual"
    end
  end # end def talks
  
  
  
  # Mega talks landing and individual pages
  def mega_talks
    if params[:id].nil? # if no paramter, then load the mega talks landing
     @talks = TalkBrand.find_by_name("Mega Talk").talks
     render "application/talks/talk_overview"
    else
      @talk = Talk.find(params[:id])
      @chapters = @talk.chapters.all
      render "application/talks/talk_individual"
    end
  end
  
  
  
  # Mega talks landing and individual pages
  def edison_talks
    if params[:id].nil? # if no paramter, then load the mega talks landing
     @talks = TalkBrand.find_by_name("Edison Talk").talks
     render "application/talks/talk_overview"
    else
      @talk = Talk.find(params[:id])
      @chapters = @talk.chapters.all
      render "application/talks/talk_individual"
    end
  end
  
  

end
