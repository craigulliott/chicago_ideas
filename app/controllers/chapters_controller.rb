class ChaptersController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]
  
  def index
    # Nice little hack for the CIW girls b/c they wanted these two items featured a the very beginning of the list
    
    if params[:year_id].present?
      @year_id = params[:year_id].to_i
      @chapters = Chapter.joins(:talk => [:day]).where("days.year_id = #{@year_id}").search_sort_paginate(params)
      @featured = Chapter.joins(:talk => [:day]).where("days.year_id = #{@year_id}").find_all_by_featured_on_talk('1')
    else
      @chapters = Chapter.archived.search_sort_paginate(params)
      @featured = Chapter.archived.find_all_by_featured_on_talk('1')
    end
    @top2 = Chapter.where("id=69 OR id=67");
    @meta_data = {:page_title => "Videos", :og_image => "/assets/images/application/logo.png", :og_title => "Videos | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  def current
    # Nice little hack for the CIW girls b/c they wanted these two items featured a the very beginning of the list
    #@top2 = Chapter.where("id=69 OR id=67");
    @chapters = Chapter.current.search_sort_paginate(params);
    @featured = Chapter.find_all_by_featured_on_talk('1')
    @meta_data = {:page_title => "Videos", :og_image => "/assets/images/application/logo.png", :og_title => "Videos | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    render :index
  end
  
  def show
    @chapter = Chapter.find(params[:id])
    @talk = @chapter.talk
    @chapters = @talk.chapters.all    
    @meta_data = {:page_title => "#{@chapter.title}", :og_image => "#{@chapter.banner(:thumb)}", :og_title => "#{@chapter.title} | Chicago Ideas Week", :og_type => "article", :og_desc => "#{@chapter.description[0..200]}"}
  end

  
end
