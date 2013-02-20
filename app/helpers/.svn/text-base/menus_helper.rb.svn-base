module MenusHelper

def get_menus(day)

  if day == 1 #monday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and monday = ?", params[:poi_id], Date.today, Date.today, true])
  elsif day == 2 #tuesday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and tuesday = ?", params[:poi_id], Date.today, Date.today, true])
  elsif day == 3 #wednesday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and wednesday = ?", params[:poi_id], Date.today, Date.today, true])
  elsif day == 4 #thursday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and thursday = ?", params[:poi_id], Date.today, Date.today, true])
  elsif day == 5 #friday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and friday = ?", params[:poi_id], Date.today, Date.today, true])
  elsif day == 6 #saturday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and saturday = ?", params[:poi_id], Date.today, Date.today, true])
  else #sunday
    Menu.find(:all, :conditions => ["poi_id = ? and init_date <= ? and date >= ? and sunday = ?", params[:poi_id], Date.today, Date.today, true])
  end



end

end
