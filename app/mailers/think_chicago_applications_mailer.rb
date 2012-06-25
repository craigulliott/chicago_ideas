class ThinkChicagoApplicationsMailer < ActionMailer::Base
  
  default :from => "bhsi_submissions@chicagoideas.com"
  default :to => "jessica@chicagoideas.com, david@davidburstein.com, corey@chicagoideas.com"
  default :subject => "BHSI Application Form Submission"
  
  def send_form(form, filename)
    @form = form
   
    attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    
  
    
    attachments["resume_#{sanitize_filename(form[:current_resume].original_filename)}"] = File.read(form[:current_resume].tempfile.path) if form[:current_resume].present?
    attachments["transcript_#{sanitize_filename(form[:unofficial_transcript].original_filename)}"] = File.read(form[:unofficial_transcript].tempfile.path) if form[:unofficial_transcript].present?
    attachments["endorsement_#{sanitize_filename(form[:faculty_endorsement].original_filename)}"] = File.read(form[:faculty_endorsement].tempfile.path) if form[:faculty_endorsement].present?
    mail()
  end
  
  private
  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_') 
  end
  
end
