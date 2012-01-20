class ChaptersController < ApplicationController
  
  def index
    @chapters = Chapter.search_sort_paginate(params)
    @featured = Chapter.find_all_by_featured_on_talk('1')
  end
  
  
  
  def show
    @chapter = Chapter.find(params[:id])
    @talk = @chapter.talk
    @chapters = @talk.chapters.all    
  end

  
end
