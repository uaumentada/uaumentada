class NotificationsMail < ActionMailer::Base

  default :from => "pucaumentada@gmail.com"
  default :to => "pucaumentada@gmail.com"

  def new_message(message)
    @message = message
    
    mail(:subject => "[feedback] #{message.subject}")
  end

end
