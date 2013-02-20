# encoding: utf-8
require "net/http"
require "uri"
require 'json'
class SessionsController < ApplicationController
  include SessionsHelper
  include ApplicationHelper

  def new
    @title = "Sign in"

    if session[:mail]
	    @user = User.find(:first, :conditions => {:email => session[:mail] })
      redirect_to(:start_menu, :notice => "Bienvenido #{@user.email}")
    end
  end

  def special
    @title = "Sign in"

    if session[:mail]
      @user = User.find(:first, :conditions => {:email => session[:mail] })
      redirect_to(:start_menu, :notice => "Bienvenido #{@user.email}")
    end
  end

# Login an admin to the site
def login_admin
	@user = User.find(:first, :conditions => {:email => params[:email] })
	if(@user && params[:password] == @user.password)
    
    set_session_params(@user)
		  
		#Set session's privileges:		  
		set_session_privileges(@user.privileges)
    
		redirect_to(:admin, :notice => "#{@user.email}")

	else
		redirect_to(:admin, :notice => "Nombre de usuario o password es incorrecto!")
	end
end

# Login an special user to the site
def login_special
  @user = User.find(:first, :conditions => {:email => params[:email] })
  if(@user && params[:password] == @user.password)
    
    set_session_params(@user)
      
    #Set session's privileges:      
    set_session_privileges(@user.privileges)
    
    redirect_to(:special_user, :notice => "#{@user.email}")

  else
    redirect_to(:special_user, :notice => "Nombre de usuario o password es incorrecto!")
  end
end
  
def tester
  
    @user = User.find(:first, :conditions => {:email => session[:mail] })
    
    privileges = Privilege.all
    privileges.each do |priv|
      
      if priv.description != "professor" && priv.description != "admin" && priv.description != "super_admin" && priv.description != "send_notifications" 
       @user.privileges << priv
      end
      
    end
    
    set_session_params(@user)
      
    #Set session's privileges:      
    set_session_privileges(@user.privileges)
    
    redirect_to(:start_menu, :notice => "#{@user.email}")
  
end  
  
  #def login
  #@user = User.find(:first, :conditions => {:email => params[:email] })
  #if(@user && params[:password] == @user.password)
   # session[:user] = @user.id
    #session[:name] = @user.name
    #session[:mail] = @user.email
      
    #Set session's privileges:      
    #set_session_privileges(@user.privileges)

    #render(:root, :notice => "#{@user.email}")

  #else
    #redirect_to(:root, :notice => "Nombre de usuario o password es incorrecto!")
  #end
  #end

  def destroy
	 reset_session
	 redirect_to(:root, :notice => "Ha salido de la sesión")
  end
  
  def new_login
    @title = "Sign in"
    check_cookies
    
    if session[:user]
      @user  = User.find(session[:user])
    end
    
    if session[:mail] && session[:admin]  #go to admin start menu
      redirect_to(:admin_menu, :notice => "#{@user.email}")
    elsif session[:mail] #go to regular start menu
      redirect_to(:start_menu, :notice => "#{@user.email}")
    else
      render
    end
  end
  
#Log university's members.
  def log_user
    
    uni = University.find(params[:university][:id])
    # Set a cookie that expires in 1 hour
    logger.info "TIME NOW: #{Time.now}"
    cookies[:login] = { :value => "temp", :expires => Time.now + 3600} #1 hr
    
    puc = "puc.cl"
    uc = "uc.cl"
    
    #log with ipre api if user is from puc
    if (uni.email.eql? puc) || (uni.email.eql? uc) 
      login_ipre(uni, params[:username], params[:password])
    else
      normal_login(uni, params[:username], params[:password])
      #redirect_to(:root, :notice => "No se puede iniciar sesión, contáctese con el administrador")
     end
  end
  
  # params:
# user
# password
def mobile_signin_uc
    uni = University.find(:first, :conditions => {:email => 'uc.cl'})

      logged = login_mobile_ipre(uni, params[:user], params[:password])
      
      if logged
        render :xml => {:result => "true"}.to_xml
        #Wrong user or password  
      else #try logging as special user
        user = User.find(:first, :conditions => {:email => params[:user] })
        if(user && params[:password] == user.password && user.university == uni)        
          render :xml => {:result => "true"}.to_xml
        else
          render :xml => {:result => "false"}.to_xml
        end
      end
end
  
  
end
