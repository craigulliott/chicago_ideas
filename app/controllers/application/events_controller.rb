#   Chicago Ideas Week
#   Events Controller
#   events_controller.rb
#
#   This controllers contains all the event like objects, including
#   talks, mega talks, labs, partner programs, etc.


class Application::EventsController < ApplicationController

  def index
    
    @talks = TalkBrand.find_by_name("Talk").talks
    @megatalks = TalkBrand.find_by_name("Mega Talk").talks
    @labs = EventBrand.find_by_name("Lab").events
    
  end
  
  
  # Talks landing and individual pages
  def talks
    if params[:id].nil? # if no paramter, then load the talks landing
     @talks = TalkBrand.find_by_name("Talk").talks
    else
      @talk = Talk.find(params[:id])
      @chapters = @talk.chapters.all
      render "application/events/talk_individual"
    end
  end # end def talks
  
  
  
  # Mega talks landing and individual pages
  def mega_talks
    if params[:id].nil? # if no paramter, then load the mega talks landing
     @megatalks = TalkBrand.find_by_name("Mega Talk").talks
    else
      @megatalk = Talk.find(params[:id])
      render "application/events/megatalk_individual"
    end
  end
  
  
  
  # Labs landing and individual pages
  def labs
    if params[:id].nil? # if no paramter, then load the labs landing
     @labs = EventBrand.find_by_name("Lab").events
    else
      @lab = Event.find(params[:id])
      render "application/events/lab_individual"
    end
  end
  
  
  
  # Partner Programs landing and individual pages
  def partner_programs
    if params[:id].nil? # if no paramter, then load the labs landing
     @partnerprograms = EventBrand.find_by_name("Partner Program").events
    else
      @partnerprogram = Event.find(params[:id])
      render "application/partner-programs/partnerprograms_individual"
    end
  end
  
end
