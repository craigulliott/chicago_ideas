class Admin::SponsorshipLevelsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @sponsorship_levels = SponsorshipLevel.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this sponsorship_level
  def show
    @section_title = 'Detail'
    @sponsorship_level = SponsorshipLevel.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this sponsorship_level
  def notes
    @sponsorship_level = SponsorshipLevel.find(params[:id])
    @notes = @sponsorship_level.notes.includes(:author).search_sort_paginate(params, :parent => @sponsorship_level)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
