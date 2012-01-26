class Admin::VolunteersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @volunteers = Volunteer.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this volunteer
  def show
    @section_title = 'Detail'
    @volunteer = Volunteer.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this volunteer
  def notes
    @volunteer = Volunteer.find(params[:id])
    @notes = @volunteer.notes.includes(:author).search_sort_paginate(params, :parent => @volunteer)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
