Rails.application.routes.draw do
 
  get 'home/index'
  resources :background_assets
  resources :assets

  root 'home#index'
end