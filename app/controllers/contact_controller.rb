class ContactController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
        if !session[:user].nil? 
        @message.subject = session[:mail]
    end
    logger.info "CREATING MESSAGE"
    if @message.valid?
      logger.info "message valid"
      NotificationsMail.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      logger.info "message not valid"
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end

