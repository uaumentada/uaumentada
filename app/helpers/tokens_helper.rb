require 'speedy_c2dm' #Gem Android push notifications

module TokensHelper
  
  
def send_push_notif(device_token, message, platform)
   
    if platform == "Android"
      options = {
  :registration_id => device_token,
  :message => message,
  :extra_data => nil,
  :collapse_key => device_token
 }

response = SpeedyC2DM::API.send_notification(options)
    end
  end
  
end
