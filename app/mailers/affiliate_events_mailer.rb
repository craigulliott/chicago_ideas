class AffiliateEventsMailer < ActionMailer::Base
  
  default :from => "forms@chicagoideas.com"
  default :to => "john@kohactive.com"
  default :subject => "Affiliate Events Form Submission"
  
  def send_form(form)
    mail(@form)
  end
  
end
