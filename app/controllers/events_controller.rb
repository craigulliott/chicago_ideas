class EventsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :labs, :partner_programs, :affiliate_event]

  def index
    @page_title = "Events"
    @talks = Talk.limit(8)
    @chapters = Chapter.limit(8)
    @speakers = User.speaker.not_deleted.limit(12).order(rand) # grab 12 speakers
  end
  
  
  def show
    @event = Event.find(params[:id])
    @page_title = "#{@event.name}"
    @partnerprograms = EventBrand.find_by_name("Partner Program").events
  end
  
  
  # Labs landing and individual pages
  def labs
   @labs = EventBrand.find_by_name("Lab").events.order('name ASC')
   @event_photos = EventPhoto.joins(:event).where('events.event_brand_id = 1').order('RAND()').limit(10)
   @event_brand = EventBrand.find_by_name('Lab')
   @page_title = "CIW Labs"
  end
  
  # Labs landing and individual pages
  def lab
    @lab = Event.find(params[:id])
    @page_title = "#{@lab.title}"
  end
  
  
  
  # Partner Programs landing and individual pages
  def partner_programs
    if params[:id].nil? # if no paramter, then load the labs landing
     @partnerprograms = EventBrand.find_by_name("Partner Program").events.order('name ASC')
     @page_title = "Partner Programs"
    else
      @partnerprogram = Event.find(params[:id])
      @page_title = "#{@partnerprogram.title}"
      render "application/partner-programs/partnerprograms_individual"
    end
  end
  
  
  # Affiliate events landing
  def affiliate_event
    @page_title = "Affiliate Events"
    @events = EventBrand.find_by_name("Affiliate Event").events
    @event_photos = EventPhoto.order('RAND()').limit(10)
  end
  
end
