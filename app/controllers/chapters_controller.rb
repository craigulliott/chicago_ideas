class ChaptersController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]
  
  def index
    @chapters = Chapter.order('RAND()').search_sort_paginate(params)
    @featured = Chapter.find_all_by_featured_on_talk('1')
    @meta_data = {:page_title => "Videos", :og_image => "/assets/images/application/logo.png", :og_title => "Videos | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  
  
  def show
    @chapter = Chapter.find(params[:id])
    @talk = @chapter.talk
    @chapters = @talk.chapters.all    
    @meta_data = {:page_title => "#{@chapter.title}", :og_image => "#{@chapter.banner(:thumb)}", :og_title => "#{@chapter.title} | Chicago Ideas Week", :og_type => "article", :og_desc => "#{@chapter.description[0..200]}"}
  end

  
end
