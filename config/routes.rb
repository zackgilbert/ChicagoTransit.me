ChicagoTransit::Application.routes.draw do
  get 'test' => 'pages#test'
  
  root :to => 'pages#index'
end
