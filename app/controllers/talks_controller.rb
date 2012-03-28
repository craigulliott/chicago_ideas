class TalksController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :show, :mega_talks, :edison_talks, :chapter]

  
  def index
    @featured = Talk.archived.order('RAND()').limit(10) # Talks specifically for the featured banner
    @talks = Talk.archived.search_sort_paginate(params)
    @tracks = Track.all
    @speakers = User.speaker.not_deleted.order('RAND()').limit(6)
    @page_title = "CIW Talks"
    @meta_data = {:page_title => "CIW Talks", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "CIW Talks | Chicago Ideas Week", :og_type => "website", :og_desc => "CIW Talks are 90-minute sessions spread throughout the week that feature 3-6 speakers presenting on various themes. Talks take a variety of forms and may incorporate interviews, conversations or performances."}
  end
  
  
  # Talks landing and individual pages
  def show
    @talk = Talk.find(params[:id])
    @chapters = @talk.chapters.all
    @page_title = "#{@talk.name}"
    @meta_data = {:page_title => "#{@talk.name}", :og_image => "#{@talk.banner_src}", :og_title => "#{@talk.name} | Chicago Ideas Week", :og_type => "article", :og_desc => "#{@talk.description[0..200]}"}
  end # end def talks
  
  
  
  # Megatalks landing and individual pages
  def mega_talks
     @megatalks = TalkBrand.find_by_name("Megatalk").talks.archived.search_sort_paginate(params)
     @talks = TalkBrand.find_by_name("Talk").talks.archived.order('name ASC')
     @meta_data = {:page_title => "CIW Megatalks", :og_image => "http://www.chicagoideas.com/assets/application/temp/speaker_landing_banner.jpg", :og_title => "CIW Megatalks | Chicago Ideas Week", :og_type => "website", :og_desc => "Megatalks are evening programs featuring distinguishd and globally recognized speakers. These influential visionaries unite in order to share their genius and inspire Chicagoans, and the world, to see beyond today and create the best for tomorrow."}
     render "talks/mega_talks"
  end
  
      
end
