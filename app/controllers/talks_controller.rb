class TalksController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show, :mega_talks, :edison_talks, :chapter]

  
  def index    
    @talks = Talk.search_sort_paginate(params)
    @megatalks = TalkBrand.find_by_name("Mega Talk").talks
    @tracks = Track.all
    @speakers = User.speaker.order('RAND()').limit(6)
    @page_title = "CIW Talks"
  end
  
  
  # Talks landing and individual pages
  def show
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
    @page_title = "#{@talk.name}"
  end # end def talks
  
  
  
  # Mega talks landing and individual pages
  def mega_talks
     @megatalks = TalkBrand.find_by_name("Mega Talk").talks
     @talks = TalkBrand.find_by_name("Talk").talks.order('name ASC')
     render "talks/mega_talks"
     @page_title = "CIW Mega Talks"
  end
  
  
  
  # Mega talks landing and individual pages
  def edison_talks
    if params[:id].nil? # if no paramter, then load the mega talks landing
     @talks = TalkBrand.find_by_name("Edison Talk").talks
     render "application/talks/talk_overview"
    else
      @talk = Talk.find(params[:id])
      @chapters = @talk.chapters.all
      render "application/talks/talk_individual"
    end
  end
  
  
  def chapter
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
    @chapter = Chapter.find(params[:id])
    render "application/talks/chapter_individual"
  end
    
end
