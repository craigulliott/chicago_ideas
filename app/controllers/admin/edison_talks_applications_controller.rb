class Admin::EdisonTalksApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @edison_talks_applications = EdisonTalksApplication.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this affiliate_event_applications
  def show
    @section_title = 'Detail'
    @edison_talks_application = EdisonTalksApplication.find(params[:id])
    
    respond_to do |format|
      format.pdf {
        
        pdf = doc_raptor_send({:document_type => "pdf".to_sym})
        friendlyName = "Edison_Talks_Application_#{@edison_talks_application.name}.pdf"
        friendlyName = friendlyName.gsub(" ", "")
        friendlyName = friendlyName.gsub("/", "_")
        File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
        @edison_talks_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
        @edison_talks_application.save!({:validate => false})
        send_data pdf, :filename => friendlyName, :type => "pdf"
        
      }
      format.html {
        render
      }
    end
    
  end
  
  
  


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this affiliate_event_applications
  def notes
    @edison_talks_application = EdisonTalksApplication.find(params[:id])
    @notes = @edison_talks_application.notes.includes(:author).search_sort_paginate(params, :parent => @edison_talks_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------


end
