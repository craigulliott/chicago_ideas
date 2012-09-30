class EdisonTalksApplicationsController < ApplicationController

  def index
    redirect_to new_edison_talks_application_path
  end
  
  def new
    @meta_data = {:page_title => "Edison Talks Application Form", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Edison Talks Application Form | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    #@edison_talks_application = EdisonTalksApplication.new
    
    render 'edison_talks_applications/index'
    
  end

  def create
    
    @meta_data = {:page_title => "Edison Talks Application Form", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Edison Talks Application Form | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    @edison_talks_application = EdisonTalksApplication.new(params[:edison_talks_application])
    
    #pdf = doc_raptor_send({:document_type => "pdf".to_sym})
    #friendlyName = "Edison_Talks_#{@edison_talks_application.first_name}_#{@edison_talks_application.last_name}.pdf"
    #friendlyName = friendlyName.gsub(" ", "")
    #friendlyName = friendlyName.gsub("/", "_")
    #File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
    #@edison_talks_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
  
    if @edison_talks_application.save
      #EdisonTalksApplicationsMailer.send_form(params[:edison_talks_application], friendlyName).deliver
      render 'application/confirmation', :locals => {:title => "Edison Talks Application Confirmation", :body => "Thank you for applying to attend the Edison Talks at Chicago Ideas Week.", :url => "http://bit.ly/OElKIh", :share_text => "I applied to to attend the Edison Talks 2012 at @chicagoideas! RT to all #innovative #socent! Apply today: http://bit.ly/OElKIh"}

    else
      flash[:notice] = 'Please fill in all required fields!'
      render :new
    end
      
    
  end
  
end
