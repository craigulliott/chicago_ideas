class SponsorsController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]


  def index
    @sponsorshipLevels = SponsorshipLevel.order("sort").all
    @meta_data = {:page_title => "Sponsors", :og_image => "http://www.chicagoideas.com/assets/application/sponsors_banner.jpg", :og_title => "Sponsors | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  def media_partners
    begin
      @media_partners_level = SponsorshipLevel.find(22)
    rescue
      @media_partners_level = SponsorshipLevel.find(2)
    end
    @meta_data = {:page_title => "Media Partners", :og_image => "http://www.chicagoideas.com/assets/application/sponsors_banner.jpg", :og_title => "Media Partners | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    render "sponsors/media_partners"
  end

end
