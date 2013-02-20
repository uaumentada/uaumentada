require "net/http" #para speedy_c2m
require "net/https" #para speedy_c2m
require 'speedy_c2dm' #Android push gem
class TokensController < ApplicationController


  # GET /tokens
  # GET /tokens.xml
  def index
    @tokens = Token.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tokens }
    end
  end

  # GET /tokens/1
  # GET /tokens/1.xml
  def show
    @token = Token.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @token }
    end
  end

  # GET /tokens/new
  # GET /tokens/new.xml
  def new
    @token = Token.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @token }
    end
  end

  # GET /tokens/1/edit
  def edit
    @token = Token.find(params[:id])
  end

  # POST /tokens
  # POST /tokens.xml
  def create
    @token = Token.new(params[:token])

    respond_to do |format|
      if @token.save
        format.html { redirect_to(@token, :notice => 'Token was successfully created.') }
        format.xml  { render :xml => @token, :status => :created, :location => @token }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @token.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tokens/1
  # PUT /tokens/1.xml
  def update
    @token = Token.find(params[:id])

    respond_to do |format|
      if @token.update_attributes(params[:token])
        format.html { redirect_to(@token, :notice => 'Token was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @token.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tokens/1
  # DELETE /tokens/1.xml
  def destroy
    @token = Token.find(params[:id])
    @token.destroy

    respond_to do |format|
      format.html { redirect_to(tokens_url) }
      format.xml  { head :ok }
    end
  end
  
  #params:
  #phone_id : the phones device  
  #platform : the phone's platform
  #email : Universities emails
  def register_device
     platform = nil
     if params[:platform].nil?
        platform = "android"
     else
        platform = params[:platform]
     end
       
     if(params[:phone_id] && params[:email])
       u = University.find(:first, :conditions => {:email => params[:email]})
        @token = Token.new(:phone_id => params[:phone_id], :platform => platform);
        @token.university = u
        if @token.save
          render :xml => {:result => "true"}.to_xml
        else
          render :xml => {:result => "false", :message => "Unable to save id", :possible_reasons => "Maybe duplicated phone_id?"}.to_xml
        end
     else
        render :xml => {:result => "false", :message => "Missing phone id or university email"}.to_xml
     end
  
  end
  
  #Called from mobile
  # params: 
  # *device_id : the phones/device's id  
  def unsubscribe_device
    
    device = Token.find(:first, :conditions => {:phone_id => params[:device_id]})
    device.active = false
    
    if device.save
          render :xml => {:result => "true"}.to_xml
    else
          render :xml => {:result => "false", :message => "Unable to unsubscribe", :possible_reasons => "unknown"}.to_xml
    end
    
  end
  
    #Called from mobile
  # params: 
  # *device_id : the phones/device's id  
  def subscribe_device
    
    device = Token.find(:first, :conditions => {:phone_id => params[:device_id]})
    device.active = true
    
    if device.save
          render :xml => {:result => "true"}.to_xml
    else
          render :xml => {:result => "false", :message => "Unable to subscribe phone", :possible_reasons => "unknown"}.to_xml
    end
    
  end
  
  def send_push

  @tokens = Token.all
  @pushmessages = PushMessage.find(:all, :conditions => {:sent => false})

  response = true
  @pushmessages.each do |pushmessage|
    
    logger.debug "MENSAJE:  #{pushmessage.message}"
    
    @tokens.each do |token|
      id = token.phone_id
      logger.debug "ID:  #{id}"
      options = {
        :registration_id => id,
        :message => pushmessage.message.to_s,
        :extra_data => "",
        :collapse_key => id
        #collapse-key:"An arbitrary string that is used to collapse a group of like messages when the device is offline, 
        #so that only the last message gets sent to the client. This is intended to avoid sending too many messages to the 
        #phone when it comes back online. Note that since there is no guarantee of the order in which messages get sent, the 
        #"last" message may not actually be the last message sent by the application server. Required."
      }
      logger.debug "OPTIONS:  #{options}"

r = false
      r = SpeedyC2DM::API.send_notification(options)

      if(!r)
        response = false
      end
      
    end
  
    if response
      pushmessage.sent = true
      pushmessage.save
    end
  end

respond_to do |format|
  if response
    @notice = 'enviado con exito'
    format.html #send_push.html.erb
    format.xml {render :xml => {:result => "true"}.to_xml }
  else
    @notice = 'No se envio el mensaje, intente nuevamente'
    format.html #send_push.html.erb
    format.xml {render :xml => {:result => "false"}.to_xml}
  end
end

end
  
  
end
