class ContactController < ApplicationController

  def contact
  end

  def dispatch_email
    user_info = params[:user_info]
    if ContactMailer.send_email(user_info).deliver
      flash[:notice] = "Sent!"
    else
      flash[:notice] = "Could't send you message."
    end
    redirect_to contact_url
  end

end