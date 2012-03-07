class Admin::VolunteersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @volunteers = Volunteer.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this volunteer
  def show
    @section_title = 'Detail'
    @volunteer = Volunteer.find(params[:id])
    
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

  # notes associated with this volunteer
  def notes
    @volunteer = Volunteer.find(params[:id])
    @notes = @volunteer.notes.includes(:author).search_sort_paginate(params, :parent => @volunteer)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
