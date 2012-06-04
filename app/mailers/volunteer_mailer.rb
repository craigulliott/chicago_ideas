class VolunteerMailer < ActionMailer::Base

  default :from => "forms@chicagoideas.com"
  default :to => "info@chicagoideas.com"
  default :subject => "Volunteer Form Submission"
  
  def send_form(form, filename)
    @form = form
    attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    mail()
  end
end
