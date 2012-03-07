class Admin::AffiliateEventApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @affiliate_event_applications = AffiliateEventApplication.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this affiliate_event_applications
  def show
    @section_title = 'Detail'
    @affiliate_event_application = AffiliateEventApplication.find(params[:id])
    
    respond_to do |format|
      
      format.pdf {
        pdfContent = doc_raptor_send
        send_data pdfContent, :filename => "#{@community_partner_application.name}.pdf", :type => "pdf"
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
    @affiliate_event_application = AffiliateEventApplication.find(params[:id])
    @notes = @affiliate_event_application.notes.includes(:author).search_sort_paginate(params, :parent => @affiliate_event_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------


end
