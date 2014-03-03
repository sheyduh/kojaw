class Message

  class ContactMailer < ActionMailer::Base

    attr_accessor :name, :email, :message

    default to: "name@kojaw.com",
            from: "contact@kojaw.com"

    headers = {'Return-Path' => 'contact@kojaw.com'}

    def send_email(user_info)
      @user_info = user_info

      mail(
        to: "name@kojaw.com",
        subject: "Kojaw's Contact Form",
        from: "Kojaw <contact@Kojaw.com>",
        return_path: "contact@Kojaw.com",
        date: Time.now,
        content_type: "text/html"
      )
    end
  end