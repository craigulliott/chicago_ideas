class Admin::ThinkChicagoApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @think_chicago_applications = ThinkChicagoApplication.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this affiliate_event_applications
  def show
    @section_title = 'Detail'
    @think_chicago_application = ThinkChicagoApplication.find(params[:id])
    
    respond_to do |format|
      format.pdf {
        
        pdf = doc_raptor_send({:document_type => "pdf".to_sym})
        friendlyName = "ThinkChicago_Application_#{@think_chicago_application.first_name}_#{@think_chicago_application.last_name}.pdf"
        friendlyName = friendlyName.gsub(" ", "")
        friendlyName = friendlyName.gsub("/", "_")
        File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
        @think_chicago_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
        @think_chicago_application.save!({:validate => false})
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
    @think_chicago_application = ThinkChicagoApplication.find(params[:id])
    @notes = @think_chicago_application.notes.includes(:author).search_sort_paginate(params, :parent => @think_chicago_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------


end
