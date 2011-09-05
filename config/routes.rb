ChicagoTransit::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'test' => 'pages#test'
    
  match "/stations" => redirect("/")
  resources :stations, :except => [:index]
  
  get 'located' => 'pages#located'
  
  root :to => 'pages#index'
end
