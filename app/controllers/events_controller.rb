class EventsController < ApplicationController

  def index
    @talks = TalkBrand.find_by_name("Talk").talks
    @megatalks = TalkBrand.find_by_name("Mega Talk").talks
    @labs = EventBrand.find_by_name("Lab").events
  end
  
  
  
  # Labs landing and individual pages
  def labs_list
   @labs = EventBrand.find_by_name("Lab").events
  end
  
  # Labs landing and individual pages
  def lab
    @lab = Event.find(params[:id])
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
