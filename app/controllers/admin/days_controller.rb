class Admin::DaysController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @days = Day.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this day
  def show
    @section_title = 'Detail'
    @day = Day.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this day
  def notes
    @day = Day.find(params[:id])
    @notes = @day.notes.includes(:author).search_sort_paginate(params, :parent => @day)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
