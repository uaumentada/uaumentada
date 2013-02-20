# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

[["Pontificia Universidad Católica", "uc.cl"]].each do |uni|
  University.find_or_create_by_name_and_email(:uni => uni[0], :email => uni[1])
end

["Charla", "Taller", "Fiesta/Concierto"].each do |category|
  Category.find_or_create_by_name(category)
end

#Careful if names are changes, they are hardcoded in some controllers (e.g. Pois)
["Baños", "Cajeros", "Centros de Alumnos","Salas de estudio", "Tiendas", "Salas", "Oficinas de Profesores", "Bibliotecas", "Crisol", "Fotocopiadoras", "Casinos y Cafeterías","Edificios"].each do |poi|
  PoiType.find_or_create_by_name(poi)
end

#[["Casa Central", "-33.44146","-70.64077"], ["Lo Contador", "-33.419496","-70.618084"], ["Oriente", "-33.445874","-70.593730"], ["San Joaquin", "-33.498586","-70.613744"]].each do |c|
 # Campus.find_or_create_by_name_and_lat_and_lng( :name => c[0],  :lat => c[1],  :lng => c[2] )
#end

#If changed, you need to change session_controller#login
["view_survey","create_events","professor","admin", "super_admin","create_survey","create_poi","diner","building_layouts","contests","send_notifications","set_ad_points","special_user","market"].each do |privilege|
  Privilege.find_or_create_by_description(privilege)
end

#Create superuser
[["Super Admin CL","superadmin@admins.cl","asdfgh123"]].each do |user|
  User.find_or_create_by_name_and_email_and_password(:name => user[0], :email => user[1], :password => user[2])
  u = User.find(:first, :conditions => {:email => "superadmin@admins.cl"})
  
  #Add privilege
  privilege = Privilege.find(:first, :conditions => {:description => "super_admin"})
  if !privilege.nil?
   u.privileges << privilege
   u.save
  end
end


