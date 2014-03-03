class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@kojaw.herokuapp.com"
  default :to => "sdemooei@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "[YourWebsite.tld] #{message.subject}")
  end

end