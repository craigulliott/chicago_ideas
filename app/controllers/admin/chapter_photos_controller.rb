class Admin::ChapterPhotosController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @chapter_photos = ChapterPhoto.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this chapter_photo
  def show
    @section_title = 'Detail'
    @chapter_photo = ChapterPhoto.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this chapter_photo
  def notes
    @chapter_photo = ChapterPhoto.find(params[:id])
    @notes = @chapter_photo.notes.includes(:author).search_sort_paginate(params, :parent => @chapter_photo)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
