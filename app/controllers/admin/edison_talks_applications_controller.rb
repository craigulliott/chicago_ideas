class Admin::EdisonTalksApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @edison_talks_applications = EdisonTalksApplication.search_sort_paginate(params)
  end
  
  def export
    @applications = EdisonTalksApplication.all # get all the users
    respond_to do |format|
      format.csv { # CSV is the only format we're concerned with for now
        csv = CSV.generate do |row| # generated the CSV
          columns = EdisonTalksApplication.csv_columns
          row << columns
          @applications.each do |a|
            row << a.csv_attributes
          end
        end
    	
    	# send .csv back to the browser
        send_data(csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=edison_talks_applications_export_" << Date.today.to_s() << ".csv") 
      }
    end
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
  
  def self.csv_columns   # class method
    ['First Name', 'Last Name', 'Email', 'Phone', 'Post Code']
  end
  
  def csv_attributes
    [get_first_name, get_last_name, get_email, get_phone, postcode]
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
