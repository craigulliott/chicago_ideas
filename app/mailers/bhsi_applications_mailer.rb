class BhsiApplicationsMailer < ActionMailer::Base
  
  default :from => "forms@chicagoideas.com"
  default :to => "brooke@chicagoideas.com"
  default :bcc => "john@kohactive.com"
  default :subject => "BHSI Application Form Submission"
  
  def send_form(form)
    @form = form
    mail()
  end
  
end
