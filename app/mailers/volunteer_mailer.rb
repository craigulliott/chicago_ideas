class VolunteerMailer < ActionMailer::Base

  default :from => "forms@chicagoideas.com"
  default :to => "info@chicagoideas.com"
  default :bcc => "john@kohactive.com"
  default :subject => "Volunteer Form Submission"
  
  def send_form(form)
    @form = form
    mail()
  end
end
