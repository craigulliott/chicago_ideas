class PressClippingsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]

  def index
     @press_clippings = PressClipping.search_sort_paginate(params)
     @page_title = "News"
   end

   def show
     @section_title = 'Detail'
     @press_clipping = PressClipping.find(params[:id])
     @page_title = "#{@press_clipping.title}"
   end
   
end
