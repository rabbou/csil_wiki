Rails.application.routes.draw do

   resources :users, only: [:new, :create]
   root to: 'sessions#templatePage'
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#templatePage'
   get 'meisterdoms', to: 'sessions#meisterdoms'
   get 'webcheckout', to: 'sessions#webcheckout'
   get 'ActivityMonitoring', to: 'sessions#ActivityMonitoring'
   get 'Backups', to: 'sessions#Backups'
   get 'Imaging', to: 'sessions#Imaging'
   get 'Inventory', to: 'sessions#Inventory'
   get 'Kiosk', to: 'sessions#Kiosk'
   get 'LoginsSecurity', to: 'sessions#LoginsSecurity'
   get 'Printing', to: 'sessions#Printing'
   get 'Scheduling', to: 'sessions#Scheduling'
   get 'Servers', to: 'sessions#Servers'
   get 'Training', to: 'sessions#Training'
   get 'Webint', to: 'sessions#Webint'
   get 'Website', to: 'sessions#Website'
   get 'Wiki', to: 'sessions#Wiki'
   get 'Testing', to: 'sessions#templatePage'
   get 'test_markdown', to: 'sessions#test_markdown'

   delete '/users.:id_from_path(.:format)' => 'users#destroy'
  match("Delete", { :controller => "pills", :action => "destroy", :via => "get"})
  match("/logout", { :controller => "sessions", :action => "logout", :via => "get"})
  match("/sign_up", { :controller => "users", :action => "registration_form", :via => "get" })

  match("/", { :controller => "users", :action => "index", :via => "get" })
 
  #------------------------------

  # Routes for the User resource:

  # CREATE
  match("/insert_user", { :controller => "users", :action => "create", :via => "post"})
          
  # READ
  match("/users", { :controller => "users", :action => "index", :via => "get"})
  
  match("/users/:id_from_path", { :controller => "users", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_user/:id_from_path", { :controller => "users", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_user/:id_from_path", { :controller => "users", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Grateful reminder resource:

  # CREATE
  match("/insert_grateful_reminder", { :controller => "grateful_reminders", :action => "create", :via => "post"})
          
  # READ
  match("/grateful_reminders", { :controller => "grateful_reminders", :action => "index", :via => "get"})
  
  match("/grateful_reminders/:id_from_path", { :controller => "grateful_reminders", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_grateful_reminder/:id_from_path", { :controller => "grateful_reminders", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_grateful_reminder/:id_from_path", { :controller => "grateful_reminders", :action => "destroy", :via => "get"})

  #------------------------------

  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
