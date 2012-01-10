class Admin::EventPhotosController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @event_photos = EventPhoto.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this event_photo
  def show
    @section_title = 'Detail'
    @event_photo = EventPhoto.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this event_photo
  def notes
    @event_photo = EventPhoto.find(params[:id])
    @notes = @event_photo.notes.includes(:author).search_sort_paginate(params, :parent => @event_photo)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
