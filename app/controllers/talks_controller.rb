class TalksController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show, :mega_talks, :edison_talks, :chapter]

  
  def index
    @featured = Talk.order('RAND()').limit(10) # Talks specifically for the featured banner
    @talks = Talk.search_sort_paginate(params)
    @tracks = Track.all
    @speakers = User.speaker.not_deleted.order('RAND()').limit(6)
    @page_title = "CIW Talks"
  end
  
  
  # Talks landing and individual pages
  def show
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
    @page_title = "#{@talk.name}"
  end # end def talks
  
  
  
  # Megatalks landing and individual pages
  def mega_talks
     @megatalks = TalkBrand.find_by_name("Megatalk").talks
     @talks = TalkBrand.find_by_name("Talk").talks.order('name ASC')
     render "talks/mega_talks"
     @page_title = "CIW Megatalks"
  end
  
  
  
  def chapter
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
    @chapter = Chapter.find(params[:id])
    render "application/talks/chapter_individual"
  end
    
end
