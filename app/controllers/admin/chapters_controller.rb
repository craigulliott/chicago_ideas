class Admin::ChaptersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @chapters = Chapter.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this chapter
  def show
    @section_title = 'Detail'
    @chapter = Chapter.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this chapter
  def notes
    @chapter = Chapter.find(params[:id])
    @notes = @chapter.notes.includes(:author).search_sort_paginate(params, :parent => @chapter)
  end

  # photos associated with this chapter
  def chapter_photos
    @chapter = Chapter.find(params[:id])
    @chapter_photos = @chapter.chapter_photos.search_sort_paginate(params, :parent => @chapter)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
