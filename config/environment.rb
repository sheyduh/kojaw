# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Kojaw::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'sheyxeare',
  :password => 'tehran1990',
  :domain => 'kojaw.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
