class VolunteersController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def new
    @meta_data = {:page_title => "Volunteer for CIW", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Volunteer for CIW | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user and current_user.volunteer.present?
      flash[:notice] = 'Thank you, your application has already been recieved.'
      redirect_to root_path
    elsif current_user
      @volunteer = current_user.build_volunteer
    else
      redirect_to new_user_registration_path, :notice => 'To apply as a Volunteer, please first create an account or log in.' 
    end
  end
  
  def create
    
    # Prevents duplicate submissions
    if current_user and current_user.volunteer.blank?
      
      @meta_data = {:page_title => "Volunteer for CIW", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Volunteer for CIW | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
      @volunteer = current_user.build_volunteer(params[:volunteer])
    
      pdf = doc_raptor_send({:document_type => "pdf".to_sym})
      friendlyName = "VolunteerApplication_#{@volunteer.user.name}.pdf"
      friendlyName = friendlyName.gsub("/", "_")
      File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
      @volunteer.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
    
      if @volunteer.save
        VolunteerMailer.send_form(params[:volunteer], friendlyName).deliver
        confirmation_text = 'You are now registered as a Chicago Ideas Week volunteer! We will contact you via email with specific volunteer opportunities as they arise. There are many ways in which you can get involved. Volunteers are the backbone of our event week, and we also enlist volunteers to assist with office support, special projects, and program coordination. We are looking for enthusiastic and highly motivated individuals to help make Chicago Ideas Week a smooth running operation and huge success. If you have associates, friends or family who would like volunteer, please encourage them to register. Thank you for your interest in Chicago Ideas Week! We are looking forward to having you on our team!'
        render 'application/confirmation', :locals => {:title => "Volunteer Application Confirmation", :body => confirmation_text, :url => "http://bit.ly/zPj9Lb", :share_text => "I'm #volunteering for @chicagoideas Oct. 8-14! Help turn #ideas into #action by signing up today: http://bit.ly/zPj9Lb" }
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
