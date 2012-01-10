class Application::CommunityController < ApplicationController

  def index
    
  end
  
  
  
  def integrated_partnerships
      @partners = Partner.find(:all)
  end # end integrated_partnerships
  
  
  
  def community_partners
    
  end # end community_partners
  

end
