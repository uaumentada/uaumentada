require 'speedy_c2dm' #Android push gem

API_ACCOUNT_EMAIL = "pucaumentada@gmail.com"
API_ACCOUNT_PASSWORD = "aumentada.123"
TEST_PHONE_C2DM_REGISTRATION_ID = "APA91bEpUgjAljW9w6lwbA_HUlx3_OZTIdUqfy1kNm5A7_oLZ66Pi5eLV7_0t11HPoYSkZ-1jP-ePDhIjVyEONzg23ReKebfQt7j-SZAQQ44Hel1jWCqbe7BEn7FEU_1XvyCDTt1bYDjCLTOt8bWomqc4jiLPoJDPQ"

options = {
  :registration_id => TEST_PHONE_C2DM_REGISTRATION_ID,
  :message => "Hi!",
  :extra_data => nil,
  :collapse_key => "some-collapse-key"
}

SpeedyC2DM::API.send_notification(options)