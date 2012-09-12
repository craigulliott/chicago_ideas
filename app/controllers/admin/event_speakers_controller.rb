class Admin::EventSpeakersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @event_speakers = EventSpeaker.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this event_speaker
  def show
    @section_title = 'Detail'
    @event_speaker = EventSpeaker.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this event_speaker
  def notes
    @event_speaker = EventSpeaker.find(params[:id])
    @notes = @event_speaker.notes.includes(:author).search_sort_paginate(params, :parent => @event_speaker)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
