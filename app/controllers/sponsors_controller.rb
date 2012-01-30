class SponsorsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]


  def index
    @sponsorshipLevels = SponsorshipLevel.order("sort").all
    @meta_data = {:page_title => "Sponsors", :og_image => "/assets/application/sponsors_banner.jpg", :og_title => "Sponsors | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  

end
