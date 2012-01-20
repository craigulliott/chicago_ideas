class TracksController < ApplicationController
  
  def index
    @tracks = Track.search_sort_paginate(params)
  end
  
  
  def show
    @track = Track.find_by_name(params[:id])
    @tracks = Track.search_sort_paginate(params)
    
    @talks = @track.talks.search_sort_paginate(params)
    @megatalks = TalkBrand.find_by_name("Mega Talk").talks

    @speakers = User.speaker.limit(6)
    render "talks/index"
  
  end
  
end