class ContactUsMailer < ActionMailer::Base

  default :to => "your@address.com"

  def send(message)
    @message = message
    mail( :subject => @message.subject, :from => @message.email ) do |format|
      format.text
    end
  end
end
