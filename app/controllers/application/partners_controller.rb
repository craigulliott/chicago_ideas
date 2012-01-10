class Application::PartnersController < ApplicationController

  def index
    @partners = Partner.find(:all)
  end
  
  
  def integrated_partnerships
    
  end

end
