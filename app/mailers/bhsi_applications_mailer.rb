class BhsiApplicationsMailer < ActionMailer::Base
  
  default :from => "bhsi_submissions@chicagoideas.com"
  #default :to => "jessica@chicagoideas.com, david@davidburstein.com, corey@chicagoideas.com"
  default :to => "justin@kohactive.com"
  default :bcc => "john@kohactive.com"
  default :subject => "BHSI Application Form Submission"
  
  def send_form(form, filename)
    @form = form
   
    attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    
  
    
    attachments["pc1_#{sanitize_filename(form[:press_clipping_1].original_filename)}"] = File.read(form[:press_clipping_1].tempfile.path) if form[:press_clipping_1].present?
    attachments["pc2_#{sanitize_filename(form[:press_clipping_2].original_filename)}"] = File.read(form[:press_clipping_2].tempfile.path) if form[:press_clipping_2].present?
    attachments["pc3_#{sanitize_filename(form[:press_clipping_3].original_filename)}"] = File.read(form[:press_clipping_3].tempfile.path) if form[:press_clipping_3].present?
    attachments["budget_#{sanitize_filename(form[:previous_budget].original_filename)}"] = File.read(form[:previous_budget].tempfile.path) if form[:previous_budget].present?
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
