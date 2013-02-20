module SessionsHelper

	#def sign_in(user)
   # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  #  self.current_user = user
 # end

#sets privileges of the user as part of the session
   def set_session_privileges(privileges)
   
   if privileges.size == 0 
    session[:no_privileges] = true
   else
   
   privileges.each do |priv|
   
   if privileges.size == 1 && priv.description == "view_survey"
    session[:no_privileges] = true
   end
   
      if priv.description == "super_admin"
        session[:super_admin] = true
        session[:admin] = true
      end
      if priv.description == "admin"
        session[:admin] = true
      end
      if priv.description == "view_survey"
        session[:view_survey] = true
      end
      if priv.description == "create_events"
        session[:create_events] = true
      end
      if priv.description == "professor"
        session[:professor] = true
      end
      if priv.description == "create_survey"
        session[:create_survey] = true
      end
      if priv.description == "create_poi"
        session[:create_poi] = true
      end
      if priv.description == "diner"
        session[:diner] = true
      end
      if priv.description == "building_layouts"
        session[:building_layouts] = true
      end
      if priv.description == "contests"
        session[:contests] = true
      end
      if priv.description == "send_notifications"
        session[:send_notifications] = true
      end
      if priv.description == "set_ad_points"
        session[:ads] = true
      end
      if priv.description == "special_user"
        session[:special_user] = true
      end
      if priv.description == "market"
        session[:market] = true
      end
      
    end
   end
   end

#sets the user info as part of the session
   def set_session_params(user)
      session[:user] = user.id
      session[:name] = user.name
      session[:mail] = user.email
      if !user.university.nil?
        session[:university] = user.university_id
      end
      
      # Set a cookie that expires in 1 hour
      logger.info "TIME NOW: #{Time.now}"
      cookies[:login] = { :value => "temp", :expires => Time.now + 3600} #1 hr
    
      
   end
   
   def set_initial_privileges(user, type)
     
     if type == "otro"
       view_survey = Privilege.find(:first, :conditions => {:description => "view_survey"})
       user.privileges << view_survey
     elsif type == "alumno"
       #View surveys
      view_survey = Privilege.find(:first, :conditions => {:description => "view_survey"})
      user.privileges << view_survey
     elsif type == "profesor"  
       prof = Privilege.find(:first, :conditions => {:description => "professor"})
       create_survey = Privilege.find(:first, :conditions => {:description => "create_survey"})
       contests = Privilege.find(:first, :conditions => {:description => "contests"})
       user.privileges << prof
       user.privileges << create_survey
       user.privileges << contests
     end     
     
      #Market
      market = Privilege.find(:first, :conditions => {:description => "market"})
      user.privileges << market
     
   end
   

  #login with ipre's code
  def login_ipre(university, user, pass)
    uri = URI.parse("http://web.ing.puc.cl/~ipre/services/login.php")

    response = Net::HTTP.post_form(uri, {"user" => user, "pass" => pass})
    logger.info "RESPONSE: #{response.body}"
        
    #Check if response OK  
    bad_credentials =  "\"ERROR: BAD CREDENTIALS\""
    bad_request =  "\"ERROR: BAD REQUEST\""
      if (!response.body.eql? bad_credentials) && (!response.body.eql? bad_request)
        data = JSON.parse(response.body)
        @user = User.find(:first, :conditions => {:email => user})
         logger.info "LOGGING #{data["nombre"]}"
         #Check if user exists
        if @user.nil?
          @user = User.new
          @user.name = data["nombre"] + " " + data["apellido_paterno"] + " "+ data["apellido_materno"]
          @user.email = user
          @user.university = university
          @user.save
          
          set_initial_privileges(@user, data["tipo"])
        end      
      
        set_session_params(@user)
      
        #Set session's privileges:      
        set_session_privileges(@user.privileges)
      
      
     if session[:mail] && session[:admin]  #go to admin start menu
      redirect_to(:admin_menu, :notice => "#{@user.email}")
    elsif session[:mail] #go to regular start menu
      redirect_to(:start_menu, :notice => "#{@user.email}")
    end
        #Wrong user or password  
      else
          redirect_to(:root, :notice => "Nombre de usuario o password es incorrecto!")
      end
  end

  def login_mobile_ipre(uni, user, pass)
    uri = URI.parse("http://web.ing.puc.cl/~ipre/services/login.php")

    response = Net::HTTP.post_form(uri, {"user" => user, "pass" => pass})
    logger.info "RESPONSE: #{response.body}"
        
    #Check if response OK  
    bad_credentials =  "\"ERROR: BAD CREDENTIALS\""
    bad_request =  "\"ERROR: BAD REQUEST\""
      if (!response.body.eql? bad_credentials) && (!response.body.eql? bad_request)
        data = JSON.parse(response.body)
        @user = User.find(:first, :conditions => {:email => user})
         logger.info "LOGGING #{data["nombre"]}"
         #Check if user exists
        if @user.nil?
          @user = User.new
          @user.name = data["nombre"] + " " + data["apellido_paterno"] + " "+ data["apellido_materno"]
          @user.email = user
          @user.university = uni
          @user.save
          
          set_market_privilege(@user)
          set_initial_privileges(@user, data["tipo"])
        end
      
        return true
        #Wrong user or password  
      else
        return false
      end
  end

  def normal_login(university, user, pass)
    #user = User.find(:first, :conditions => {:email => params[:username] })
    
    #user must exist, password has to match, and correct university must be selected
      if(user && pass == user.password && user.university == university)        
        
        set_session_params(user)
      
        #Set session's privileges:      
        set_session_privileges(user.privileges)

        redirect_to(:root, :notice => "#{user.email}")

    else
      redirect_to(:root, :notice => "Nombre de usuario, password y/o universidad es incorrecto!")
    end
  end

end
