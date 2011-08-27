ChicagoTransit::Application.routes.draw do
  get 'test' => 'pages#test'
  
  match "/station" => redirect("/")
  match 'station/:station', :to => 'pages#index'
  root :to => 'pages#index'
end
