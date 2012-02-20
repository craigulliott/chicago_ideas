class YearsController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:show]
  
  def show
    @meta_data = {:page_title => "2012 Chicago Ideas Week", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
end
