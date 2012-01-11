class Admin::PressClippingsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @press_clippings = PressClipping.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this press_clipping
  def show
    @section_title = 'Detail'
    @press_clipping = PressClipping.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this press_clipping
  def notes
    @press_clipping = PressClipping.find(params[:id])
    @notes = @press_clipping.notes.includes(:author).search_sort_paginate(params, :parent => @press_clipping)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
