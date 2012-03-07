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
        
        if !@community_partner_application.pdf.exists?
          pdf = doc_raptor_send({:document_type => "pdf".to_sym})
          friendlyName = "CPA_#{@community_partner_application.name}.pdf"
          File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
          @community_partner_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
          @community_partner_application.save!({:validate => false})
          send_data pdf, :filename => friendlyName, :type => "pdf"
        else
          redirect_to @community_partner_application.pdf.url
        end

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
