class ThinkChicagoApplicationsController < ApplicationController

  def index
    redirect_to new_think_chicago_application_path
  end
  
  def new
    @meta_data = {:page_title => "ThinkChicago Application Form", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "ThinkChicago Application Form | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    @think_chicago_application = ThinkChicagoApplication.new
  end

  def create
    
    @meta_data = {:page_title => "ThinkChicago Application Form", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "ThinkChicago Application Form | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    @think_chicago_application = ThinkChicagoApplication.new(params[:think_chicago_application])
    
    #pdf = doc_raptor_send({:document_type => "pdf".to_sym})
    #friendlyName = "ThinkChicago_#{@think_chicago_application.first_name}_#{@think_chicago_application.last_name}.pdf"
    #friendlyName = friendlyName.gsub(" ", "")
    #friendlyName = friendlyName.gsub("/", "_")
    #File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
    #@think_chicago_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
  
    if @think_chicago_application.save
      #ThinkChicagoApplicationsMailer.send_form(params[:think_chicago_application], friendlyName).deliver
      render 'application/confirmation', :locals => {:title => "ThinkChicago Application Confirmation", :body => "Thank you for applying to ThinkChicago 2012.", :url => "http://bit.ly/NXyJJ9", :share_text => "I applied to ThinkChicago 2012 at @chicagoideas! RT to all #innovative #socent! Apply today: http://bit.ly/MkbMy5"}

    else
      flash[:notice] = 'Please fill in all required fields!'
      render :new
    end
      
    
  end
  
end
