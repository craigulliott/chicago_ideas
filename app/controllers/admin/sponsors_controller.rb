class Admin::SponsorsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @sponsors = Sponsor.by_sort.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this sponsor
  def show
    @section_title = 'Detail'
    @sponsor = Sponsor.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this sponsor
  def notes
    @sponsor = Sponsor.find(params[:id])
    @notes = @sponsor.notes.includes(:author).search_sort_paginate(params, :parent => @sponsor)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
