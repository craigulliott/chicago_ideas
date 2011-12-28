class Admin::PerformancesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @performances = Performance.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this performance
  def show
    @section_title = 'Detail'
    @performance = Performance.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this performance
  def notes
    @performance = Performance.find(params[:id])
    @notes = @performance.notes.includes(:author).search_sort_paginate(params, :parent => @performance)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
