class PressClippingsController < ApplicationController

  def index
     @press_clippings = PressClipping.search_sort_paginate(params)
   end

   def show
     @section_title = 'Detail'
     @press_clipping = PressClipping.find(params[:id])
   end
   
end
