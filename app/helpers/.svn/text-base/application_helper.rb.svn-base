module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
    def sortable_menu (column, title = nil, poi_id)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :poi_id => poi_id}, {:class => css_class}
  end
  
  #object_user : user that owns the object
  #user_id : id of the logged user
  def has_permission(object_user)
    
    if session[:super_admin]
      return true
    end
    
    if !session[:user].nil?
      user = User.find(session[:user])
    else
      return false
    end
    
    if object_user.id == user.id
      true
    elsif session[:admin] && object_user.university == user.university
      true
    elsif session[:super_admin]
      true
    else
      false
    end
    
  end
  
  def same_university(object_uni)
    if !session[:user].nil?
      user = User.find(session[:user])
    else
      return false
    end
    
    if object_uni.id == user.university.id
      true
    else
      false
    end
    
  end
  
  def check_cookies
    if cookies[:login].nil?
     session[:user] = nil 
     session[:mail] = nil 
    end
  end
  
  def get_campus_id(campus_title)
  
    if !campus_title.nil?
      campus = Campus.find(:first, :conditions => {:name => campus_title})
    else  
      nil
    end
  
  end
  
end
