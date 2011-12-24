class AdminMailer < ActionMailer::Base

  helper :email
  layout 'email'
  default :from => "#{BUSINESS_NAME} <#{BUSINESS_EMAIL}>"

  def contact_form(contact_params)
    @name = contact_params[:name]
    @email = contact_params[:email]
    @message = contact_params[:message]

    # headers to track everything through sendgrid
    headers({'X-SMTPAPI' => '{"category": "Contact Form"}'})

    mail(:to => BUSINESS_EMAIL, :subject => 'Contact form was filled out')
  end

end
