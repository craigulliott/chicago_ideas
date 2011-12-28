class Admin::VenuesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @venues = Venue.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this venue
  def show
    @section_title = 'Detail'
    @venue = Venue.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this venue
  def notes
    @venue = Venue.find(params[:id])
    @notes = @venue.notes.includes(:author).search_sort_paginate(params, :parent => @venue)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
