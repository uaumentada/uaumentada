# encoding: utf-8
class PushMessagesController < ApplicationController

# GET /PushMessages/new
  # GET /PushMessages/new.xml
  def new
    @push_message = PushMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @push_message }
    end
  end

# POST /push_message
  # POST /push_message.xml
  def create
    @push_message = PushMessage.new(params[:push_message])
    @push_message.user = User.find(session[:user])
    @push_message.sent = false
 
 logger.debug "LOCALTIME #{Time.now}"
 time = Time.now
 hour = time.hour.to_s
 min = time.min.to_s
 if min.size == 1
   min = "0"+ min
 end
 year = time.year.to_s
 month = time.month.to_s
  if month.size == 1
   month = "0"+ month
 end
 day = time.day.to_s
  if day.size == 1
   day = "0"+ day
 end
 @push_message.message =@push_message.message + " ;;" + day + "/" +month+"/"+year+" "+hour+":"+min
 
  if @push_message.save
       redirect_to :controller => 'tokens', :action => 'send_push'
  else
    render :action => "new"
  end
end

#Get latest notifications
# returns the last 5 notifications
def get_messages

  @push_messages = PushMessage.find(:all, :conditions => {:sent => true}, :order => "id desc", :limit => 5)
  
  respond_to do |format|
      format.html # new.html.erb
      format.json #get_messages.json.erb
    end
  end
end
