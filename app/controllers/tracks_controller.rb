class TracksController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]
  
  def index
    @tracks = Track.search_sort_paginate(params)
    @page_title = "Topics"
  end
  
  
  def show
  
  end
  
end