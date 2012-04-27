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
        #if !@affiliate_event_application.pdf.exists?
          pdf = doc_raptor_send({:document_type => "pdf".to_sym})
          friendlyName = "AEA_#{@affiliate_event_application.organization_name}.pdf"
          File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
          @affiliate_event_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
          @affiliate_event_application.save!({:validate => false})
          send_data pdf, :filename => friendlyName, :type => "pdf"
        # else
        #   redirect_to @affiliate_event_application.pdf.url
        # end
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
