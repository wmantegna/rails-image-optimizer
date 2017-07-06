Rails.application.routes.draw do
 
  get 'home/index'
  resources :background_assets
  resources :assets

  # resque_web
  #################
  require "resque_web"
  mount ResqueWeb::Engine => "/resque_web"
  #################

  root 'home#index'
end