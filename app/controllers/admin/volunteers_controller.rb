require 'csv'
class Admin::VolunteersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @volunteers = Volunteer.search_sort_paginate(params)
  end
  
  def export
    @users = Volunteer.all # get all the users
    respond_to do |format|
      format.csv { # CSV is the only format we're concerned with for now
        csv = CSV.generate do |row| # generated the CSV
          row << ['First Name', 'Last Name', 'Email', 'Phone', 'Post Code']
          @users.each do |volunteer|
            
            first_name = ((volunteer.first_name).strip.length > 0) ? (volunteer.first_name).strip : ''
            last_name = ((volunteer.last_name).strip.length > 0) ? (volunteer.last_name).strip : ''

            if first_name.length == 0 or last_name.length == 0
              name = volunteer.user.name
              idx = name.index(' ')
              if !idx.nil?
                first_name = name[0..idx]
                last_name = name[(idx+1)..name.length]
              end
            end
            
            email = (volunteer.email.strip.length > 0) ? volunteer.email.strip : volunteer.user.email.strip
            phone = (volunteer.phone.strip.length > 0) ? volunteer.phone.strip : (!volunteer.user.phone.nil? ? volunteer.user.phone.strip : '')
            postcode = volunteer.postcode
            row << [first_name, last_name, email, phone, postcode] # add a volunteer's name, email, phone, and postcode
          end
        end
    	
    	# send .csv back to the browser
        send_data(csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=volunteers_export_" << Date.today.to_s() << ".csv") 
      }
    end
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
        
         #if !@volunteer.pdf.exists?
          pdf = doc_raptor_send({:document_type => "pdf".to_sym})
          friendlyName = "Volunteer_#{@volunteer.user.name}.pdf"
          friendlyName = friendlyName.gsub("/", "_")
          File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
          @volunteer.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
          @volunteer.save!({:validate => false})
          send_data pdf, :filename => friendlyName, :type => "pdf"
        #else
         # redirect_to @volunteer.pdf.url
        #end
        
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
