class Notifier < ActionMailer::Base
  default :from => 'info@kojaw.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thank you for Signing up!' )
  end
end