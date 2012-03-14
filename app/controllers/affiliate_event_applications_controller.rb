class AffiliateEventApplicationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    @meta_data = {:page_title => "Affiliate Events", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Affiliate Events | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.affiliate_event_application.present?
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.'
    elsif current_user
      @affiliate_event_application = current_user.build_affiliate_event_application
    else
      redirect_to new_user_registration_path, :notice => 'To submit your application, please first create an account or log in.' 
    end
  end

  def create
    # Prevents duplicate submissions
    if current_user and current_user.affiliate_event_application.blank?
      
      @meta_data = {:page_title => "Affiliate Events", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Affiliate Events | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
      @affiliate_event_application = current_user.build_affiliate_event_application(params[:affiliate_event_application])
    
      pdf = doc_raptor_send({:document_type => "pdf".to_sym})
      friendlyName = "AEA_#{@affiliate_event_application.organization_name}.pdf"
      File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
      @affiliate_event_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");

      if @affiliate_event_application.save
      
        AffiliateEventsMailer.send_form(params[:affiliate_event_application],friendlyName).deliver
        #redirect_to root_path, :notice => 'Thank you, your application has been recieved.'
        render 'application/confirmation', :locals => {:title => "Affiliate Event Application Confirmation", :body => "Thank you for applying. We will be in contact shortly.", :url => "#{affiliate_event_events_path}" }

      else
        flash[:notice] = 'Please fill in all required fields!'
        render :new
      end
    else
      redirect_to root_path, :notice => 'Thank you, your application has already been recieved.' 
    end
  end
  
end
