ChicagoTransit::Application.routes.draw do
  get 'test' => 'pages#test'
  

  #match 'station/:station', :to => 'pages#index'
  
  match "/station" => redirect("/")
  resources :stations, :except => [:index]
  
  root :to => 'pages#index'
end
