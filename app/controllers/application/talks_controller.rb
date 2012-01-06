class Application::TalksController < ApplicationController

  def index
    @talks = Talk.find(:all)
  end
  
  
  
  def show
    
  end

end
