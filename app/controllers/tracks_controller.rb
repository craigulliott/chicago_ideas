class TracksController < ApplicationController
  
  def index
    @tracks = Track.search_sort_paginate(params)
  end
  
  
  def show
  
  end
  
end