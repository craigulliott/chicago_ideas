class PressClippingsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]

  def index
     @press_clippings = PressClipping.order('created_at desc').search_sort_paginate(params)
     @page_title = "News"
     @meta_data = {:page_title => "CIW News", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "News | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
   end

   def show
     @section_title = 'Detail'
     @press_clipping = PressClipping.find(params[:id])
     @page_title = "#{@press_clipping.title}"
   end
   
end
