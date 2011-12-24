# Craig Ulliott
# in development, send all email to the developer and not the actual recipient
# this is useful for testing, and also prevents us accidentally emailing real members
class DevelopmentMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = DEVELOPER_EMAIL
  end

end