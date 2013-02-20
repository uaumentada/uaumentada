class StartController < ApplicationController
  include ApplicationHelper
  
def index

  #redirect_to :controller => :users, :action => :new

end

def menu

end

def map

end

def admin_menu
   check_cookies
   if (session[:user])
      @user  = User.find(session[:user])
  
    if session[:super_admin] 
        @petitions = Professor.find(:all, :conditions => {:approved => false})
    else
        @petitions = Professor.find(:all, :include => [:user => :university], :conditions => {:approved => false, :universities => {:email => @user.university.email }})
        
    end
  else
    redirect_to :root
  end
end

end
