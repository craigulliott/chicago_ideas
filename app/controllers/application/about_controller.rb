class Application::AboutController < ApplicationController

  # About landing page
  def index
    
  end
  
  
  # Staff page
  def staff
    
    if params[:id].nil? 
      @staff = User.staff
    else
      @staff = User.find(params[:id]) # individual staff page
      render "application/about/staff_individual"
    end
    
  end # end staff
  
  
  # volunteer
  def volunteer
    
  end 

end