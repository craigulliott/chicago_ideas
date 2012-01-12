class Application::SponsorsController < ApplicationController

  def index
    @sponsorshipLevels = SponsorshipLevel.order("sort").all
  end
  
  

end
