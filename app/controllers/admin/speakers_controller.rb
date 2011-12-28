class Admin::SpeakersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @speakers = Speaker.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this speaker
  def show
    @section_title = 'Detail'
    @speaker = Speaker.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this speaker
  def notes
    @speaker = Speaker.find(params[:id])
    @notes = @speaker.notes.includes(:author).search_sort_paginate(params, :parent => @speaker)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
