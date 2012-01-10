class Admin::TalkPhotosController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @talk_photos = TalkPhoto.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this talk_photo
  def show
    @section_title = 'Detail'
    @talk_photo = TalkPhoto.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this talk_photo
  def notes
    @talk_photo = TalkPhoto.find(params[:id])
    @notes = @talk_photo.notes.includes(:author).search_sort_paginate(params, :parent => @talk_photo)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
