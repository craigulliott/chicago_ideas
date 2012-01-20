class EventsController < ApplicationController

  def index
    @talks = Talk.limit(8)
    @chapters = Chapter.limit(8)
    @speakers = User.speaker.limit(12).order(rand) # grab 12 speakers
  end
  
  
  
  # Labs landing and individual pages
  def labs
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
  
  
  # Affiliate events landing
  def affiliate_event
    @events = EventBrand.find_by_name("Affiliate Event").events
  end
  
end
