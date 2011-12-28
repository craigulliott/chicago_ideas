class Admin::TalkBrandsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @talk_brands = TalkBrand.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this talk_brand
  def show
    @section_title = 'Detail'
    @talk_brand = TalkBrand.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this talk_brand
  def notes
    @talk_brand = TalkBrand.find(params[:id])
    @notes = @talk_brand.notes.includes(:author).search_sort_paginate(params, :parent => @talk_brand)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
