class TracksController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]
  
  def index
    @tracks = Track.search_sort_paginate(params)
    @page_title = "Topics"
  end
  
  
  def show
    @track = Track.find_by_name(params[:id])
    @tracks = Track.search_sort_paginate(params)
    
    @talks = @track.talks.search_sort_paginate(params)
    @megatalks = TalkBrand.find_by_name("Megatalk").talks

    @speakers = User.speaker.limit(6)
    render "talks/index"
  
  end
  
end