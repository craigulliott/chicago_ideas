class Admin::EventsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @events = Event.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this event
  def show
    @section_title = 'Detail'
    @event = Event.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this event
  def notes
    @event = Event.find(params[:id])
    @notes = @event.notes.includes(:author).search_sort_paginate(params, :parent => @event)
  end

  # photos associated with this event
  def event_photos
    @event = Event.find(params[:id])
    @event_photos = @event.event_photos.search_sort_paginate(params, :parent => @event)
  end

  # photos associated with this event
  def event_speakers
    @event = Event.find(params[:id])
    @event_speakers = @event.event_speakers.search_sort_paginate(params, :parent => @event)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
