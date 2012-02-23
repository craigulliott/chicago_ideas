class ApplicationMailer < ActionMailer::Base

  helper :email
  layout 'email'
  default :from => "#{ENV['BUSINESS_NAME']} <#{ENV['BUSINESS_EMAIL']}>"

  def welcome(user)
    raise 'user has no email address' unless user.email.present?

    # headers to track everything through sendgrid
    headers({'X-SMTPAPI' => '{"category": "Welcome Email"}'})

    @user = user
    mail(:to => @user.email, :subject => "Welcome to #{ENV['BUSINESS_NAME']}")
  end
  
end
