class PartnersController < ApplicationController

  def index
    @partners = Partner.all
  end
  
  
  # Apply to be a partner form & page
  def apply
    
  end

end
