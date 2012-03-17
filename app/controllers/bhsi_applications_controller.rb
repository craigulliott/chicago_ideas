class BhsiApplicationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]
  
  def new
    @meta_data = {:page_title => "Bluhm/Helfand Social Innovation Fellowship", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Bluhm/Helfand Social Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.bhsi_application.present?
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.'
    elsif current_user
      @bhsi_application = current_user.build_bhsi_application
    else
      redirect_to new_user_registration_path, :notice => 'To submit your application, please first create an account or log in.' 
    end
  end

  def create
    
    # Prevent duplicate submissions
    if current_user and current_user.bhsi_application.blank?
      
      @meta_data = {:page_title => "Bluhm/Helfand Social Innovation Fellowship", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Bluhm/Helfand Social Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
      @bhsi_application = current_user.build_bhsi_application(params[:bhsi_application])
    
      pdf = doc_raptor_send({:document_type => "pdf".to_sym})
      friendlyName = "Bhsi_#{@bhsi_application.social_venture_name}.pdf"
      File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
      @bhsi_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
    
      if @bhsi_application.save
        BhsiApplicationsMailer.send_form(params[:bhsi_application], friendlyName).deliver
        render 'application/confirmation', :locals => {:title => "BHSI Application Confirmation", :body => "Thank you for applying to the Bluhm/Helfand Social Innovation Fellowship. BHSI semi-finalists will be announced in mid-June.", :url => "#{blum_helfand_path}", :share_text => "I applied to the #BHSI Fellowship at @chicagoideas! RT to all #innovative #socent! Applications close 5/21. Apply today: "}

      else
        flash[:notice] = 'Please fill in all required fields!'
        render :new
      end
      
    else
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.' 
    end
    
  end
  
end