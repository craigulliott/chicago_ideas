class Admin::StaffBiosController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @staff_bios = StaffBio.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this staff_bio
  def show
    @section_title = 'Detail'
    @staff_bio = StaffBio.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this staff_bio
  def notes
    @staff_bio = StaffBio.find(params[:id])
    @notes = @staff_bio.notes.includes(:author).search_sort_paginate(params, :parent => @staff_bio)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
