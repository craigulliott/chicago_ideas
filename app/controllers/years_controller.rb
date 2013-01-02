class YearsController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:show]
  
  def show
    begin
      @speakers = []
      @speakers << User.find(2699) # Diane Von Furstenburg
      @speakers << User.find(2695) # Elle Macpherson
      @speakers << User.find(2037) # General Colin Powell
      @speakers << User.find(1272) # Tom Brokaw
      @speakers << User.find(1846) # Deepak Chopra
      @speakers << User.find(1848) # Edward Norton
      @speakers << User.find(1960) # Ali Velshi
    rescue
      @speakers = User.speaker.not_deleted.current.limit(7)
    end
    
    #@chapters = Chapter.current
    @talks = Talk.current.order('name asc')
    @meta_data = {:page_title => "2013 Chicago Ideas Week", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
end
