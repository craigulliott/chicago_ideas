class Admin::BhsiApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @bhsi_applications = BhsiApplication.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this affiliate_event_applications
  def show
    @section_title = 'Detail'
    @bhsi_application = BhsiApplication.find(params[:id])
    
    respond_to do |format|
      format.pdf {
        
        #if Rails.env == 'development' or !@bhsi_application.pdf.exists?
          pdf = doc_raptor_send({:document_type => "pdf".to_sym})
          friendlyName = "BHSI_Application_#{@bhsi_application.first_name}_#{@bhsi_application.last_name}.pdf"
          File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
          @bhsi_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
          @bhsi_application.save!({:validate => false})
          send_data pdf, :filename => friendlyName, :type => "pdf"
        #else
          #redirect_to @bhsi_application.pdf.url
        #end
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
    @bhsi_application = BhsiApplication.find(params[:id])
    @notes = @bhsi_application.notes.includes(:author).search_sort_paginate(params, :parent => @bhsi_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------


end
