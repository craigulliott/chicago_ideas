class Admin::MemberTypesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @member_types = MemberType.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this member_type
  def show
    @section_title = 'Detail'
    @member_type = MemberType.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this member_type
  def notes
    @member_type = MemberType.find(params[:id])
    @notes = @member_type.notes.includes(:author).search_sort_paginate(params, :parent => @member_type)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
