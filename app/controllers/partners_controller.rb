class PartnersController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index, :apply]


  def index
    @partners = Partner.all
    @page_title = "CIW Partners"
  end
  
  
  # Apply to be a partner form & page
  def apply
    
  end

end
