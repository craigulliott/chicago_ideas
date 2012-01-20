class Admin::TracksController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @tracks = Track.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this track
  def show
    @section_title = 'Detail'
    @track = Track.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this track
  def notes
    @track = Track.find(params[:id])
    @notes = @track.notes.includes(:author).search_sort_paginate(params, :parent => @track)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
