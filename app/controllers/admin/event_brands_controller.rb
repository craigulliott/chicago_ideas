class Admin::EventBrandsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @event_brands = EventBrand.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this event_brand
  def show
    @section_title = 'Detail'
    @event_brand = EventBrand.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this event_brand
  def notes
    @event_brand = EventBrand.find(params[:id])
    @notes = @event_brand.notes.includes(:author).search_sort_paginate(params, :parent => @event_brand)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
