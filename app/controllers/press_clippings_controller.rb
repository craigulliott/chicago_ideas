class PressClippingsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show]

  def index
     if params[:year_id].present?
       @year_id = params[:year_id].to_i
       @press_clippings = PressClipping.where("news_type <> 'Press Release' AND DATE_FORMAT(created_at, '%Y') = :year_id", {:year_id => @year_id}).order('created_at desc').search_sort_paginate(params)
     else
       @press_clippings = PressClipping.where("news_type <> 'Press Release'").order('created_at desc').search_sort_paginate(params)
     end
     
     @page_title = "In the News"
     @meta_data = {:page_title => "In the News", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "News | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
   end

   def releases
     if params[:year_id].present?
       @year_id = params[:year_id].to_i
       @press_clippings = PressClipping.where("news_type = 'Press Release' AND DATE_FORMAT(created_at, '%Y') = :year_id", {:year_id => @year_id}).order('created_at desc').search_sort_paginate(params)
     else
       @press_clippings = PressClipping.where("news_type = 'Press Release'").order('created_at desc').search_sort_paginate(params)
     end
     @page_title = "Press Releases"
     @meta_data = {:page_title => "Press Releases", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "News | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
   end
   
   def newsroom
     @press_clippings = PressClipping.where("news_type <> 'Press Release'").order('created_at desc').search_sort_paginate(params)
     @page_title = "Newsroom"
     @meta_data = {:page_title => "Newsroom", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "News | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
   end
   
   def show
     @section_title = 'Detail'
     @press_clipping = PressClipping.find(params[:id])
     @page_title = "#{@press_clipping.title}"
   end
   
end
