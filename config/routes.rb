ChicagoTransit::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'test' => 'pages#test'
    
  match "/station" => redirect("/")
  resources :stations, :except => [:index]
  
  root :to => 'pages#index'
end
