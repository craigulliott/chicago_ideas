class CommunityPartnerApplicationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    @meta_data = {:page_title => "Community Partners", :og_image => "http://www.chicagoideas.com/assets/images/application/logo.png", :og_title => "Community Partners | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.community_partner_application.present?
      flash[:notice] = 'Thank you, your application has already been recieved.'
      redirect_to root_path
    elsif current_user
      @community_partner_application = current_user.build_community_partner_application
    else
      redirect_to new_user_registration_path, :notice => 'To submit your organization, please first create an account or log in.' 
    end
  end
  
  def create
    if current_user and current_user.community_partner_application.blank?
      @meta_data = {:page_title => "Community Partners", :og_image => "http://www.chicagoideas.com/assets/images/application/logo.png", :og_title => "Community Partners | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
      @community_partner_application = current_user.build_community_partner_application(params[:community_partner_application])

      pdf = doc_raptor_send({:document_type => "pdf".to_sym})
      friendlyName = "CommunityPartner_#{@community_partner_application.name}.pdf"
      File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
      @community_partner_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
    
      if @community_partner_application.save
        CommunityPartnersMailer.send_form(params[:community_partner_application], friendlyName).deliver
        render 'application/confirmation', :locals => {:title => "Community Partner Application Confirmation", :body => "Thank you for applying. We will be in contact shortly.", :url => "http://bit.ly/xtTO7B", :share_text => "I just applied to be a @chicagoideas Community Partner! Join the convo w/ #idea makers & big #thinkers. Apply today: http://bit.ly/xtTO7B"}
      else
        flash[:notice] = 'Please fill in all required fields!'
        render :new
      end
    else
      flash[:notice] = 'Thank you, your application has already been recieved.'
      redirect_to root_path
    end
  end
    
end
