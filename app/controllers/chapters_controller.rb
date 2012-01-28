class ChaptersController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]
  
  def index
    @page_title = "Videos"
    @chapters = Chapter.order('RAND()').search_sort_paginate(params)
    @featured = Chapter.find_all_by_featured_on_talk('1')
  end
  
  
  
  def show
    @chapter = Chapter.find(params[:id])
    @talk = @chapter.talk
    @chapters = @talk.chapters.all    
    @page_title = "#{@chapter.title}"
  end

  
end
