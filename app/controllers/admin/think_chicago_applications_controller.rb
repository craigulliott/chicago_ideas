require 'csv'
class Admin::ThinkChicagoApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @think_chicago_applications = ThinkChicagoApplication.search_sort_paginate(params)
  end

  def export
    @applications = ThinkChicagoApplication.all # get all the users
    respond_to do |format|
      format.csv { # CSV is the only format we're concerned with for now
        csv = CSV.generate do |row| # generated the CSV
          columns = ThinkChicagoApplication.csv_columns
          row << columns
          @applications.each do |a|
            row << a.csv_attributes
          end
        end
    	
    	# send .csv back to the browser
        send_data(csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=thinkchicago_applications_export_" << Date.today.to_s() << ".csv") 
      }
    end
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
