Rails.application.routes.draw do
 
  resources :background_assets
  resources :assets, to: "assets"
  root 'assets#index'
end
