Rails.application.routes.draw do
  get '/search' => 'traceip#search'
  
  root 'traceip#index'
end
