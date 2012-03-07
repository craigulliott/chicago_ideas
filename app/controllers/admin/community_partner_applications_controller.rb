class Admin::CommunityPartnerApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @community_partner_applications = CommunityPartnerApplication.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this community_partner_application
  def show
    @section_title = 'Detail'
    @community_partner_application = CommunityPartnerApplication.find(params[:id])
      
    respond_to do |format|
      
      format.pdf {
        pdfContent = doc_raptor_send
        send_data pdfContent, :filename => "CPA_#{@community_partner_application.name}.pdf", :type => "pdf"
      }
      format.html {
        render
      }
    end
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this community_partner_application
  def notes
    @community_partner_application = CommunityPartnerApplication.find(params[:id])
    @notes = @community_partner_application.notes.includes(:author).search_sort_paginate(params, :parent => @community_partner_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
