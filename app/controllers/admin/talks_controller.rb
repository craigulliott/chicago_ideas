class Admin::TalksController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @talks = Talk.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this talk
  def show
    @section_title = 'Detail'
    @talk = Talk.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this talk
  def notes
    @talk = Talk.find(params[:id])
    @notes = @talk.notes.includes(:author).search_sort_paginate(params, :parent => @talk)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
