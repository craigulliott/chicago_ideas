class PartnersController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :apply]


  def index
    @partners = Partner.all
    @page_title = "CIW Partners"
    @meta_data = {:page_title => "CIW Partners", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "CIW Partners | Chicago Ideas Week", :og_type => "website", :og_desc => ""}
  end
  
end
