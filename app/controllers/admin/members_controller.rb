class Admin::MembersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @members = Member.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this member
  def show
    @section_title = 'Detail'
    @member = Member.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this member
  def notes
    @member = Member.find(params[:id])
    @notes = @member.notes.includes(:author).search_sort_paginate(params, :parent => @member)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
