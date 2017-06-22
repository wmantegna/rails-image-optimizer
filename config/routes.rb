Rails.application.routes.draw do
 
  resources :assets, to: "assets"
  root 'assets#index'
end
