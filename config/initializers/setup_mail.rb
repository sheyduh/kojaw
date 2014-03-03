ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 465,
  :domain               => "kojaw.com",
  :user_name            => "sheyda@kojaw.com",
  :password             => "tehran1990",
  :authentication       => "plain",
  :enable_starttls_auto => true
}