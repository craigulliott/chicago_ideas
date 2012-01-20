class SponsorsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]


  def index
    @sponsorshipLevels = SponsorshipLevel.order("sort").all
    @page_title = "Sponsors"
  end
  
  

end
