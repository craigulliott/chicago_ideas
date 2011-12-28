class Admin::PartnersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @partners = Partner.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this partner
  def show
    @section_title = 'Detail'
    @partner = Partner.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this partner
  def notes
    @partner = Partner.find(params[:id])
    @notes = @partner.notes.includes(:author).search_sort_paginate(params, :parent => @partner)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
