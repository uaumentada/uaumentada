Pucaumentada::Application.routes.draw do
  resources :universities

  resources :ads_points

  resources :menus

  resources :contests

  resources :tokens
  resources :push_messages, :only => [:new, :create]
  resources :professors

  resources :market_items

  resources :pois

  resources :events
  resources :indoor_maps
  resources :courses

  resources :privileges

  get "sessions/new_login"

  resources :surveys
  resources :answers
  resources :questions
  resources :users
  resources :campus
  
  resources :categories
  resources :poi_types
  
  resources :sessions, :only => [:new, :destroy]

  #Session
  match '/admin',  :to => 'sessions#new', :as => :admin
  match '/specialuser',  :to => 'sessions#special', :as => :special_user
  match '/signout', :to => 'sessions#destroy'
  #match '/login' => 'sessions#login'
  #match '/new_login' => 'sessions#new_login', :as => :login
  match '/log_user' => 'sessions#log_user'
  match '/login_admin' => 'sessions#login_admin'
  match '/login_special' => 'sessions#login_special'
  
  match '/menu' => 'start#menu', :as => :start_menu
  match '/admin_menu' => 'start#admin_menu', :as => :admin_menu
  match '/send_answer' => 'answers#send_answer'
  match '/view_answers/:survey_id' => 'answers#view_answers', :as => :view_answers

  #User
  match '/allusers' => 'users#index', :as => :allusers
  match '/signup',  :to => 'users#new', :as => :signup
  match '/editpassword', :to => 'users#edit_password', :as => :edit_password
  match '/changepassword', :to => 'users#change_password'
  match '/editprofile', :to => 'users#edit_profile'
  match '/profile', :to => 'users#show'
  match '/new_admin', :to => 'users#new_admin'
  match '/profile/:id', :to => 'users#profile'
  match '/updateprofile', :to => 'users#update_profile'

  #Mobile
  #match '/new_mobile', :to => 'users#new_mobile'
  match '/mobile_signup', :to => 'users#mobile_signup'
  match '/mobile_signin_uc', :to => 'sessions#mobile_signin_uc'

  #Events
  match '/user_events' => 'events#user_events', :as => :user_events
  match '/get_event_categories' => 'categories#get_common_names'

  #Pois
  match '/get_poi' => 'pois#get_poi'
  match '/delete_poi' =>'pois#destroy_poi'
  match '/get_polygons' => 'pois#get_polygons'
  match '/new_update_available' => 'pois#new_update_available'
  #Pois#Buildings
  match '/my_buildings' => 'pois#my_buildings'
  match '/all_buildings' => 'pois#all_buildings'
  match '/create_building' => 'pois#create_building'
  match '/new_building' => 'pois#new_building', :as => :new_building
  match '/edit_building' => 'pois#edit_building'
  match '/update_building' => 'pois#update_building'
  match '/get_buildings' => 'pois#get_buildings'
  #Pois#Diners
  match '/my_diners' => 'pois#my_diners'
  match '/my_diners_clean' => 'pois#my_diners_clean'
  match '/create_diner' => 'pois#create_diner'
  match '/new_diner' => 'pois#new_diner', :as => :new_diner
  match '/get_diners' => 'pois#get_diners'
  match '/edit_diner' => 'pois#edit_diner'
  
  #Vertex
  match 'new_polygon' => 'vertex#new_building'
  match 'create_polygon' => 'vertex#create_polygon'
  match 'view_vertex' => 'vertex#show'

  #Surveys & Questions
  match '/survey_questions/:survey_id' => 'questions#survey_questions', :as => :survey_questions #Get survey
  match '/survey_code/:code' => 'questions#survey_code' #Get survey
  match '/surveys/close_survey' => 'surveys#close_survey'  #Toggle public
  match '/surveys/publish' => 'surveys#publish' #Toggle public
  match '/surveys/:id/edit' => 'surveys#edit'
  match '/new_survey' => 'surveys#new'
  match '/user_surveys' => 'surveys#user_surveys', :as => :user_surveys
  match '/get_public_surveys' => 'surveys#get_public_surveys'
  match '/get_course_surveys' => 'surveys#get_course_surveys'
  match '/get_geolocalized_surveys' => 'surveys#get_geolocalized'
  match '/clone_survey' => 'surveys#clone'
  match '/move_up' => 'questions#move_up', :as => :move_up
  match '/move_down' => 'questions#move_down', :as => :move_down
  match '/questions/new' => 'questions#new'

  #Campus
  match 'campus/new' => 'campus#new'
  match 'campus/:id' => 'campus#show'

  #Courses
  match '/get_courses' => 'courses#get_courses'
  match '/get_user_courses' => 'courses#get_user_courses'
  match '/subscribe_course' => 'courses#subscribe_course'
  match '/unsubscribe_course' => 'courses#unsubscribe_course'
  match '/my_courses' => 'courses#user_courses'

  #Pois
  match '/get_pois' => 'pois#get_pois'
  match '/get_common_names' => 'pois#get_common_names'

  #MarketItems
  match '/new_item' => 'market_items#new_item' #To create from mobile
  match '/edit_item' => 'market_items#edit_item' #To edit from mobile
  match '/my_items' => 'market_items#my_items' #To view my items in mobile
  match '/delete_item' => 'market_items#delete_item' #To delete one item from mobile

  #Professors
  match '/checkin' => 'professors#checkin'
  match '/toggle' => 'professors#toggle'
  match '/get_professors' => 'professors#get_professors'
  match '/assign_poi' => 'professors#assign_poi'
  match '/assign' => 'professors#assign'
  match '/petitions' => 'professors#petitions'
  match '/petition' => 'professors#petition'
  
  #Indoor_mapping
  match '/indoor_mapping' => 'indoor_maps#indoor_map'
  match '/delete_map' => 'indoor_maps#delete_map'
  
  #Push
  match '/notify_device_id' => 'tokens#register_device'
  match '/unsubscribe_device' => 'tokens#unsubscribe_device'
  match '/subscribe_device' => 'tokens#subscribe_device'
  match '/send_push' => 'tokens#send_push'
  match '/get_messages' => 'push_messages#get_messages'
  
  #Contests
  match '/my_contests' => 'contests#my_contests', :as => :my_contests
  
  #Menus
  match '/mobile_menus' => 'menus#mobile_menus'
  
  #Ads
  match '/index_ads_events' => 'ads_points#index_ads_events'
  match '/assign_ad_to_event' => 'ads_points#assign_ad_to_event'
  match '/remove_ad_from_event' => 'ads_points#remove_ad_from_event'
  match '/index_ads_contests' => 'ads_points#index_ads_contests'
  match '/assign_ad_to_contest' => 'ads_points#assign_ad_to_contest'
  match '/remove_ad_from_contest' => 'ads_points#remove_ad_from_contest'
  match '/get_advertisements_points' => 'ads_points#get_ads_points'
  
  #ADMIN-privileges
  match '/user_privileges' => 'privileges#user_privileges', :as => :user_privileges
  match '/assign_privileges' => 'privileges#assign', :as => :assign_privileges
  match '/remove_privileges' => 'privileges#remove_privilege'

  #mail
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  
  #Tester
  match '/set_tester' => 'sessions#tester', :as => 'set_tester'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "sessions#new_login"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
